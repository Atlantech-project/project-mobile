import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Who is calling: the app version and this device's id. Read once at start.
class ClientInfo {
  const ClientInfo({required this.appVersion, required this.deviceId});

  static const _channel = MethodChannel('io.atlantech.mobile/device');

  /// The version name from pubspec (`1.0.0`), compared by the server with
  /// `min_app_version`.
  final String appVersion;

  /// Android `ANDROID_ID`: stable for this app on this device, survives a
  /// reinstall signed with the same key. `null` if the platform did not
  /// answer.
  final String? deviceId;

  static Future<ClientInfo> load() async {
    final package = await PackageInfo.fromPlatform();
    String? deviceId;
    try {
      deviceId = await _channel.invokeMethod<String>('getDeviceId');
    } on PlatformException catch (e) {
      debugPrint('ClientInfo: no device id ($e)');
    } on MissingPluginException catch (e) {
      debugPrint('ClientInfo: no device id ($e)');
    }
    return ClientInfo(appVersion: package.version, deviceId: deviceId);
  }
}
