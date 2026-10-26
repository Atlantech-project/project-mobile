import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Whether the device has a network (Wi-Fi, mobile data or Ethernet).
/// `true` means online. Drives the header connection status and, later, the
/// Outbox (MB-F4).
///
/// Starts as online so the header does not flash "Offline" while the first
/// check runs.
// TODO(MB-F2): also go offline when the API health check fails, so a Wi-Fi
// network that cannot reach the port server shows as offline too.
class ConnectionCubit extends Cubit<bool> {
  ConnectionCubit({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity(),
      super(true) {
    // If the platform check fails, keep the last known state.
    _subscription = _connectivity.onConnectivityChanged.listen(
      _update,
      onError: (Object _) {},
    );
    unawaited(
      _connectivity.checkConnectivity().then(_update, onError: (Object _) {}),
    );
  }

  final Connectivity _connectivity;
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  bool get isOnline => state;

  void _update(List<ConnectivityResult> results) {
    if (isClosed) return;
    emit(results.any((r) => r != ConnectivityResult.none));
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
