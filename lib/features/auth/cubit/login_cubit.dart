import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/app_exception.dart';
import '../../../core/models/field_user.dart';
import '../../../core/models/outbox_event.dart';
import '../../../core/router/session_state.dart';
import '../../sync/data/outbox_repository.dart';
import '../data/auth_repository.dart';

enum LoginMode { signIn, changePassword }

/// Why a field is not valid.
enum LoginFieldError { required, tooShort, lettersAndNumbers, mismatch }

/// The message above the form (Figma "State feedback").
enum LoginFeedback {
  none,
  signingIn,
  invalidCredentials,

  /// 401 on a signed-in request: the same user must sign in again.
  sessionExpired,
  accountDisabled,
  tooManyAttempts,
  serverError,
}

class LoginState {
  const LoginState({
    this.mode = LoginMode.signIn,
    this.feedback = LoginFeedback.none,
    this.submitting = false,
    this.usernameError,
    this.passwordError,
    this.confirmError,
    this.fixedUsername,
    this.pendingEvents = 0,
    this.pendingOwner,
  });

  final LoginMode mode;
  final LoginFeedback feedback;
  final bool submitting;
  final LoginFieldError? usernameError;
  final LoginFieldError? passwordError;
  final LoginFieldError? confirmError;

  /// Set after a session expired: only this user may sign in to send the
  /// events they saved.
  final String? fixedUsername;

  /// Unsent Outbox events of [pendingOwner] on this device.
  final int pendingEvents;
  final String? pendingOwner;

  LoginState copyWith({
    LoginMode? mode,
    LoginFeedback? feedback,
    bool? submitting,
    LoginFieldError? usernameError,
    LoginFieldError? passwordError,
    LoginFieldError? confirmError,
    bool clearErrors = false,
  }) => LoginState(
    mode: mode ?? this.mode,
    feedback: feedback ?? this.feedback,
    submitting: submitting ?? this.submitting,
    usernameError: clearErrors ? null : (usernameError ?? this.usernameError),
    passwordError: clearErrors ? null : (passwordError ?? this.passwordError),
    confirmError: clearErrors ? null : (confirmError ?? this.confirmError),
    fixedUsername: fixedUsername,
    pendingEvents: pendingEvents,
    pendingOwner: pendingOwner,
  );
}

/// P-52 Tablet Login, including the first-login password change.
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._auth, this._outbox, this._session)
    : super(const LoginState()) {
    reset();
  }

  final AuthRepository _auth;
  final OutboxRepository _outbox;
  final SessionState _session;

  /// Reads the session again: expired session, account disabled, unsent
  /// events.
  void reset() {
    final last = _session.lastUser;
    final pending = last == null
        ? 0
        : _outbox.events
              .where(
                (e) =>
                    e.userId == last.userId &&
                    (e.status == OutboxStatus.pending ||
                        e.status == OutboxStatus.sending),
              )
              .length;
    final expired = _session.sessionExpired && last != null;
    emit(
      LoginState(
        feedback: expired
            ? LoginFeedback.sessionExpired
            : _session.accountDisabled
            ? LoginFeedback.accountDisabled
            : LoginFeedback.none,
        fixedUsername: expired ? last.username : null,
        pendingEvents: pending,
        pendingOwner: pending > 0 ? last?.username : null,
      ),
    );
  }

  Future<void> signIn(String username, String password) async {
    final user = state.fixedUsername ?? username.trim();
    final userError = user.isEmpty ? LoginFieldError.required : null;
    final passError = password.isEmpty ? LoginFieldError.required : null;
    if (userError != null || passError != null) {
      emit(
        state.copyWith(
          clearErrors: true,
          usernameError: userError,
          passwordError: passError,
          feedback: _keepSessionFeedback,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        clearErrors: true,
        submitting: true,
        feedback: LoginFeedback.signingIn,
      ),
    );
    await _run(() => _auth.login(username: user, password: password));
  }

  Future<void> changePassword(String newPassword, String confirm) async {
    LoginFieldError? newError;
    if (newPassword.isEmpty) {
      newError = LoginFieldError.required;
    } else if (newPassword.length < 8) {
      newError = LoginFieldError.tooShort;
    } else if (!RegExp('[A-Za-z]').hasMatch(newPassword) ||
        !RegExp('[0-9]').hasMatch(newPassword)) {
      newError = LoginFieldError.lettersAndNumbers;
    }
    final confirmError = confirm.isEmpty
        ? LoginFieldError.required
        : confirm != newPassword
        ? LoginFieldError.mismatch
        : null;
    if (newError != null || confirmError != null) {
      emit(
        state.copyWith(
          clearErrors: true,
          passwordError: newError,
          confirmError: confirmError,
        ),
      );
      return;
    }
    emit(state.copyWith(clearErrors: true, submitting: true));
    await _run(() => _auth.changePassword(newPassword));
  }

  LoginFeedback get _keepSessionFeedback =>
      state.feedback == LoginFeedback.sessionExpired
      ? LoginFeedback.sessionExpired
      : LoginFeedback.none;

  Future<void> _run(Future<FieldUser> Function() call) async {
    try {
      final user = await call();
      if (isClosed) return;
      emit(state.copyWith(submitting: false, feedback: LoginFeedback.none));
      // The router moves on to My Tasks (or P-20 for a non-field role).
      _session.signIn(user.role, user: user);
    } on ForbiddenException catch (e) {
      if (isClosed) return;
      if (e.isPasswordChangeRequired) {
        emit(
          state.copyWith(
            mode: LoginMode.changePassword,
            submitting: false,
            feedback: LoginFeedback.none,
          ),
        );
      } else {
        emit(
          state.copyWith(
            submitting: false,
            feedback: e.isAccountDisabled
                ? LoginFeedback.accountDisabled
                : LoginFeedback.serverError,
          ),
        );
      }
    } on UnauthorizedException {
      if (!isClosed) {
        emit(
          state.copyWith(
            submitting: false,
            feedback: LoginFeedback.invalidCredentials,
          ),
        );
      }
    } on TooManyAttemptsException {
      if (!isClosed) {
        emit(
          state.copyWith(
            submitting: false,
            feedback: LoginFeedback.tooManyAttempts,
          ),
        );
      }
    } on NetworkException {
      // Offline: the screen shows the connection notice.
      if (!isClosed) {
        emit(state.copyWith(submitting: false, feedback: _keepSessionFeedback));
      }
    } on AppException {
      if (!isClosed) {
        emit(
          state.copyWith(
            submitting: false,
            feedback: LoginFeedback.serverError,
          ),
        );
      }
    }
  }
}
