import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../localization/l10n/app_localizations.dart';
import '../localization/locale_cubit.dart';
import 'app_icon_button.dart';

/// Header button that switches between Arabic and English.
class AppLanguageButton extends StatelessWidget {
  const AppLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      icon: Icons.translate,
      tooltip: AppLocalizations.of(context).switchLanguage,
      onPressed: () => context.read<LocaleCubit>().toggle(),
    );
  }
}
