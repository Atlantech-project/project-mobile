import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/app_config.dart';

/// Holds the active app locale. Starts at [AppConfig.defaultLocale].
// TODO(MB-F3): persist the chosen locale in local storage.
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(AppConfig.defaultLocale);

  void setLocale(Locale locale) {
    if (!AppConfig.supportedLocales.contains(locale)) return;
    emit(locale);
  }

  void toggle() => emit(
    state.languageCode == 'ar' ? const Locale('en') : const Locale('ar'),
  );
}
