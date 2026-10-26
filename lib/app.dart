import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/config/app_config.dart';
import 'core/di/injection.dart';
import 'core/localization/l10n/app_localizations.dart';
import 'core/localization/locale_cubit.dart';
import 'core/network/connection_cubit.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class AtlantechApp extends StatelessWidget {
  const AtlantechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>.value(value: getIt<LocaleCubit>()),
        BlocProvider<ConnectionCubit>.value(value: getIt<ConnectionCubit>()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) => MaterialApp.router(
          onGenerateTitle: (context) => AppLocalizations.of(context).appName,
          theme: AppTheme.light,
          locale: locale,
          supportedLocales: AppConfig.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: getIt<AppRouter>().router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
