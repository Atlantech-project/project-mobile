import 'package:dio/dio.dart';

import '../api_contract.dart';

/// Sends this device's id, which names the device token on the server.
class DeviceIdInterceptor extends Interceptor {
  DeviceIdInterceptor(this._deviceId);

  final String? _deviceId;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final deviceId = _deviceId;
    if (deviceId != null) options.headers[ApiHeaders.deviceId] = deviceId;
    handler.next(options);
  }
}
