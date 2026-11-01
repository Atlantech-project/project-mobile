import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/app_exception.dart';
import '../../../core/models/port_info.dart';
import '../../../core/router/session_state.dart';
import '../data/auth_repository.dart';

/// P-53 states from the Figma frames. READ_ONLY frames are deferred (DEC-54).
enum PortStatus {
  loading,

  /// "Server identity loaded".
  loaded,

  /// "Server unavailable": no answer from the server.
  unavailable,

  /// "Identity verification failed": online, but no valid identity.
  verificationFailed,

  /// "Connected port appears incorrect": the user said it is not their port.
  incorrect,
}

class PortState {
  const PortState({this.status = PortStatus.loading, this.port});

  final PortStatus status;
  final PortInfo? port;

  bool get canContinue => status == PortStatus.loaded && port != null;
}

/// P-53 Port Identification.
class PortCubit extends Cubit<PortState> {
  PortCubit(this._repository, this._session) : super(const PortState());

  final AuthRepository _repository;
  final SessionState _session;

  Future<void> load() async {
    emit(const PortState());
    try {
      final port = await _repository.identifyPort();
      if (isClosed) return;
      emit(PortState(status: PortStatus.loaded, port: port));
    } on NetworkException {
      if (!isClosed) emit(const PortState(status: PortStatus.unavailable));
    } on AppException {
      if (!isClosed) {
        emit(const PortState(status: PortStatus.verificationFailed));
      }
    }
  }

  void markIncorrect() =>
      emit(PortState(status: PortStatus.incorrect, port: state.port));

  /// Saves the port. The screen then moves on to sign-in.
  void confirm() {
    final port = state.port;
    if (!state.canContinue || port == null) return;
    _session.markPortIdentified(port);
  }
}
