import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/mock/mock_backend.dart';
import '../../../core/mock/mock_data.dart';
import '../../../core/models/outbox_event.dart';
import '../../../core/network/connection_cubit.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/router/session_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/dev_scenario_menu.dart';
import '../../../core/widgets/widgets.dart';
import '../../sync/data/outbox_repository.dart';
import '../cubit/login_cubit.dart';
import '../data/auth_repository.dart';

/// P-52 Tablet Login (Figma 245:7734): sign-in, sign in again after an
/// expired session, and the first-login password change.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(
        getIt<AuthRepository>(),
        getIt<OutboxRepository>(),
        getIt<SessionState>(),
      ),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _syncFixedUsername(context.read<LoginCubit>().state);
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _syncFixedUsername(LoginState state) {
    final fixed = state.fixedUsername;
    if (fixed != null) _username.text = fixed;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppScaffold(
      backdrop: true,
      header: AppHeader(
        subtitle: l10n.loginHeaderSubtitle,
        actions: const [AppConnectionStatus(), AppLanguageButton()],
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listenWhen: (a, b) =>
            a.fixedUsername != b.fixedUsername || a.mode != b.mode,
        listener: (context, state) {
          _syncFixedUsername(state);
          _password.clear();
          _confirm.clear();
        },
        builder: (context, state) => DevScenarioMenu(
          scenarios: _devScenarios(context),
          child: _panel(context, state),
        ),
      ),
    );
  }

  Widget _panel(BuildContext context, LoginState state) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<LoginCubit>();
    final online = context.watch<ConnectionCubit>().state;
    final session = getIt<SessionState>();
    final isChange = state.mode == LoginMode.changePassword;
    final expired = state.feedback == LoginFeedback.sessionExpired;
    final disabled = state.feedback == LoginFeedback.accountDisabled;
    final muted = AppTextStyles.bodyM.copyWith(color: AppColors.textMuted);

    final title = isChange
        ? l10n.loginChangeTitle
        : expired
        ? l10n.loginAgainTitle
        : l10n.loginTitle;

    // Figma "Port context": the port, or the account on first login.
    final (contextLabel, contextValue, contextNote) = isChange
        ? (
            l10n.loginAccountLabel,
            l10n.loginFirstLogin,
            l10n.loginFirstLoginNote,
          )
        : disabled
        ? (
            l10n.loginPortLabel,
            l10n.loginAccountDisabled,
            l10n.loginAccountDisabledNote,
          )
        : (
            l10n.loginPortLabel,
            session.port?.portName ?? l10n.loginPortNotConfirmed,
            session.port == null
                ? l10n.loginPortNotConfirmedNote
                : l10n.loginPortServerNote,
          );

    final notice = _notice(l10n, state, online);
    final canSubmit = online && !state.submitting;

    final footnote = isChange
        ? l10n.loginChangeFootnote
        : disabled
        ? l10n.loginDisabledFootnote
        : state.pendingOwner != null
        ? l10n.loginOutboxFootnote(state.pendingOwner!)
        : l10n.loginFootnote;

    final passwordToggle = _VisibilityToggle(
      visible: _showPassword,
      onTap: () => setState(() => _showPassword = !_showPassword),
    );

    final fields = isChange
        ? [
            AppTextField(
              label: l10n.loginNewPassword,
              hintText: l10n.loginNewPasswordHint,
              helperText: l10n.loginPasswordRule,
              controller: _password,
              obscureText: !_showPassword,
              errorText: _fieldError(l10n, state.passwordError),
              textInputAction: TextInputAction.next,
            ),
            AppTextField(
              label: l10n.loginConfirmPassword,
              hintText: l10n.loginConfirmPasswordHint,
              controller: _confirm,
              obscureText: !_showPassword,
              errorText: _fieldError(l10n, state.confirmError),
              trailing: passwordToggle,
              onSubmitted: (_) =>
                  cubit.changePassword(_password.text, _confirm.text),
            ),
          ]
        : [
            AppTextField(
              label: l10n.loginUsername,
              hintText: l10n.loginUsernameHint,
              helperText: state.fixedUsername != null
                  ? l10n.loginUsernameFixed
                  : null,
              controller: _username,
              enabled: state.fixedUsername == null,
              textDirection: TextDirection.ltr,
              errorText: state.usernameError == null
                  ? null
                  : l10n.loginUsernameRequired,
              textInputAction: TextInputAction.next,
            ),
            AppTextField(
              label: l10n.loginPassword,
              hintText: l10n.loginPasswordHint,
              controller: _password,
              obscureText: !_showPassword,
              errorText: state.passwordError == null
                  ? null
                  : l10n.loginPasswordRequired,
              trailing: passwordToggle,
              onSubmitted: canSubmit
                  ? (_) => cubit.signIn(_username.text, _password.text)
                  : null,
            ),
          ];

    final button = isChange
        ? AppButton.primary(
            label: l10n.loginChangeAction,
            icon: Icons.save_outlined,
            expand: true,
            isLoading: state.submitting,
            onPressed: canSubmit
                ? () => cubit.changePassword(_password.text, _confirm.text)
                : null,
          )
        : AppButton.primary(
            label: state.submitting
                ? l10n.loginSigningInAction
                : l10n.loginAction,
            icon: Icons.login,
            expand: true,
            isLoading: state.submitting,
            onPressed: canSubmit
                ? () => cubit.signIn(_username.text, _password.text)
                : null,
          );

    final isTablet = context.isTablet;
    final panel = Container(
      padding: EdgeInsetsDirectional.all(
        isTablet ? AppSpacing.s6 : AppSpacing.s5,
      ),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: AppRadius.smAll,
        border: Border.all(
          color: AppColors.borderDefault,
          width: AppSizes.borderThin,
        ),
        boxShadow: AppShadows.elevation3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.s6,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.s3,
            children: [
              const AppLogo(),
              Text(
                title,
                style: isTablet ? AppTextStyles.h3Size26 : AppTextStyles.h3,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.s3,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      contextLabel,
                      style: AppTextStyles.bodyL.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  Text(contextValue, style: AppTextStyles.h3),
                ],
              ),
              Text(contextNote, style: muted),
            ],
          ),
          ?notice,
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.s5,
            children: fields,
          ),
          button,
          Text(footnote, style: muted),
        ],
      ),
    );

    return LayoutBuilder(
      builder: (context, box) => SingleChildScrollView(
        padding: EdgeInsetsDirectional.all(context.layout.margin),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: box.maxHeight - 2 * context.layout.margin,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _panelWidth),
              child: panel,
            ),
          ),
        ),
      ),
    );
  }

  /// Figma "Sign-in panel" is 640 wide.
  static const double _panelWidth = 640;

  Widget? _notice(AppLocalizations l10n, LoginState state, bool online) {
    final pending = state.pendingEvents;
    final (String title, String message)? text = switch (state.feedback) {
      LoginFeedback.signingIn => (
        l10n.loginSigningInTitle,
        l10n.loginSigningInMessage,
      ),
      LoginFeedback.invalidCredentials => (
        l10n.loginInvalidTitle,
        l10n.loginInvalidMessage,
      ),
      LoginFeedback.sessionExpired when !online => (
        l10n.loginExpiredTitle,
        l10n.loginExpiredMessage(pending),
      ),
      LoginFeedback.sessionExpired => (
        l10n.loginReauthTitle,
        l10n.loginReauthMessage(pending, state.fixedUsername ?? ''),
      ),
      LoginFeedback.tooManyAttempts => (
        l10n.loginTooManyTitle,
        l10n.errorTooManyAttempts,
      ),
      LoginFeedback.serverError => (
        l10n.loginServerErrorTitle,
        l10n.errorServerError,
      ),
      _ when !online => (
        l10n.loginOfflineTitle,
        l10n.loginOfflineMessage(pending),
      ),
      _ => null,
    };
    if (text == null) return null;
    return AppNotice(
      title: text.$1,
      message: text.$2,
      tone: AppStatusTone.neutral,
      stacked: true,
    );
  }

  String? _fieldError(AppLocalizations l10n, LoginFieldError? error) =>
      switch (error) {
        null => null,
        LoginFieldError.required => l10n.loginNewPasswordRequired,
        LoginFieldError.tooShort => l10n.loginPasswordTooShort,
        LoginFieldError.lettersAndNumbers => l10n.loginPasswordLettersNumbers,
        LoginFieldError.mismatch => l10n.loginPasswordMismatch,
      };

  // DEV-ONLY (Flutter Screens)
  List<DevScenario> _devScenarios(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    final backend = getIt<MockBackend>();
    final session = getIt<SessionState>();

    void expire({required bool online}) {
      backend
        ..prepareUser(MockData.pilot)
        ..setOnline(online);
      session.signIn(MockData.pilot.role, user: MockData.pilot);
      if (!backend.outbox.any((e) => e.status == OutboxStatus.pending)) {
        backend.seedEvent(status: OutboxStatus.pending);
      }
      session.expireSession();
      cubit.reset();
    }

    void signInAs(String username, [String password = 'Passw0rd']) {
      backend.setOnline(true);
      _username.text = username;
      _password.text = password;
      cubit.signIn(username, password);
    }

    return [
      DevScenario('Default (online)', () {
        backend.setOnline(true);
        cubit.reset();
      }),
      DevScenario('Offline connection', () => backend.setOnline(false)),
      DevScenario('Missing required fields', () => cubit.signIn('', '')),
      DevScenario(
        'Invalid credentials',
        () => signInAs('m.farid', MockData.wrongPassword),
      ),
      DevScenario('Session expired · offline', () => expire(online: false)),
      DevScenario('Reauthentication required', () => expire(online: true)),
      DevScenario('First login · change password', () => signInAs('new.pilot')),
      DevScenario('Account disabled', () => signInAs('disabled.user')),
      DevScenario('Sign in · Marine Pilot', () => signInAs('m.farid')),
      DevScenario('Sign in · Tug Master', () => signInAs('s.hassan')),
      DevScenario('Sign in · CT Supervisor', () => signInAs('n.adel')),
      DevScenario('Sign in · web role (P-20)', () => signInAs('web.user')),
    ];
  }
}

/// Figma "Password visibility control": Show / Hide text, 80 × 56.
class _VisibilityToggle extends StatelessWidget {
  const _VisibilityToggle({required this.visible, required this.onTap});

  final bool visible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Semantics(
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.smAll,
        child: Container(
          constraints: const BoxConstraints(minWidth: AppSizes.touch),
          height: AppSizes.touch,
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.s5,
          ),
          alignment: Alignment.center,
          child: Text(
            visible ? l10n.loginHidePassword : l10n.loginShowPassword,
            style: AppTextStyles.h4,
          ),
        ),
      ),
    );
  }
}
