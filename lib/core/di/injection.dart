import 'package:get_it/get_it.dart';

import '../localization/locale_cubit.dart';
import '../router/app_router.dart';
import '../router/session_state.dart';

final getIt = GetIt.instance;

/// Registers every shared object. Call once from `main()`.
void setupInjection() {
  getIt
    ..registerLazySingleton<SessionState>(SessionState.new)
    ..registerLazySingleton<LocaleCubit>(LocaleCubit.new)
    ..registerLazySingleton<AppRouter>(() => AppRouter(getIt<SessionState>()));
}
