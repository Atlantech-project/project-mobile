import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/app_config.dart';
import '../storage/meta_store.dart';

/// Holds the active app locale. Starts at the saved language, or
/// [AppConfig.defaultLocale] before the first change. Every change is saved
/// in the meta box (MB-F3).
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this._meta) : super(_meta.locale ?? AppConfig.defaultLocale);

  final MetaStore _meta;

  void setLocale(Locale locale) {
    if (!AppConfig.supportedLocales.contains(locale)) return;
    _change(locale);
  }

  void toggle() => _change(
    state.languageCode == 'ar' ? const Locale('en') : const Locale('ar'),
  );

  void _change(Locale locale) {
    emit(locale);
    unawaited(_meta.saveLocale(locale));
  }
}
