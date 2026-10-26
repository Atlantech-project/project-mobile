import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/app_config.dart';

/// Whether the port server is reachable. `true` means online: the device has
/// a network (Wi-Fi, mobile data or Ethernet) **and** the server answers the
/// health check. A Wi-Fi without the port VPN therefore shows as offline.
/// Drives the header connection status and, later, the Outbox (MB-F4).
///
/// Starts as online so the header does not flash "Offline" while the first
/// check runs. While there is a network it re-checks every
/// [AppConfig.healthCheckInterval].
class ConnectionCubit extends Cubit<bool> {
  ConnectionCubit({
    required Future<bool> Function() ping,
    Connectivity? connectivity,
    Duration interval = AppConfig.healthCheckInterval,
  }) : _ping = ping,
       _connectivity = connectivity ?? Connectivity(),
       _interval = interval,
       super(true) {
    // If the platform check fails, keep the last known state.
    _subscription = _connectivity.onConnectivityChanged.listen(
      _onConnectivity,
      onError: (Object _) {},
    );
    unawaited(
      _connectivity.checkConnectivity().then(
        _onConnectivity,
        onError: (Object _) {},
      ),
    );
  }

  final Future<bool> Function() _ping;
  final Connectivity _connectivity;
  final Duration _interval;
  late final StreamSubscription<List<ConnectivityResult>> _subscription;
  Timer? _timer;
  bool _hasNetwork = true;
  Future<bool>? _inFlight;

  bool get isOnline => state;

  /// Pings the server now. The sync engine calls it before sending.
  Future<bool> recheck() {
    if (!_hasNetwork) return Future.value(false);
    return _inFlight ??= _runPing().whenComplete(() => _inFlight = null);
  }

  Future<bool> _runPing() async {
    final reachable = await _ping();
    if (!isClosed && _hasNetwork) emit(reachable);
    return reachable;
  }

  void _onConnectivity(List<ConnectivityResult> results) {
    if (isClosed) return;
    _hasNetwork = results.any((r) => r != ConnectivityResult.none);
    if (!_hasNetwork) {
      _timer?.cancel();
      _timer = null;
      emit(false);
      return;
    }
    unawaited(recheck());
    _timer ??= Timer.periodic(_interval, (_) => unawaited(recheck()));
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    await _subscription.cancel();
    return super.close();
  }
}
