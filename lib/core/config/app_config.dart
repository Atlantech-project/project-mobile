import 'package:flutter/widgets.dart';

/// App-wide configuration and defaults.
abstract final class AppConfig {
  static const String baseUrl = 'https://app.atlantech.io/api/v1';

  /// The app starts in Arabic (RTL). Change here to start in English.
  static const Locale defaultLocale = Locale('ar');

  static const List<Locale> supportedLocales = [Locale('ar'), Locale('en')];
}
