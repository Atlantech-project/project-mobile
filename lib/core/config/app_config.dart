import 'package:flutter/widgets.dart';

/// App-wide configuration and defaults.
abstract final class AppConfig {
  /// The fixed port server address. Split DNS resolves it to the port's own
  /// server. A dev build can point elsewhere with
  /// `--dart-define=API_BASE_URL=https://...`.
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://app.atlantech.io/api/v1',
  );

  /// Sent as `platform` at sign-in (CT-04: `ANDROID` or `IOS`). The app is
  /// Android only.
  static const String platform = 'ANDROID';

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration sendTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  /// The connection check (`GET /system/info`) must answer fast or the
  /// server counts as unreachable.
  static const Duration connectionCheckTimeout = Duration(seconds: 5);

  /// How often [ConnectionCubit] re-checks the server while the device has a
  /// network.
  static const Duration healthCheckInterval = Duration(seconds: 30);

  /// The offline ATLANTECH Root CA that signs every port's TLS certificate.
  static const String rootCaAsset = 'assets/certs/atlantech_root_ca.pem';

  /// The app starts in Arabic (RTL). Change here to start in English.
  static const Locale defaultLocale = Locale('ar');

  static const List<Locale> supportedLocales = [Locale('ar'), Locale('en')];
}
