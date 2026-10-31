import 'package:get_it/get_it.dart';

import '../localization/locale_cubit.dart';
import '../network/client_info.dart';
import '../network/connection_cubit.dart';
import '../network/dio_client.dart';
import '../network/interceptors/app_version_interceptor.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../network/interceptors/device_id_interceptor.dart';
import '../network/interceptors/forbidden_interceptor.dart';
import '../network/interceptors/idempotency_interceptor.dart';
import '../network/root_ca.dart';
import '../network/token_store.dart';
import '../router/app_router.dart';
import '../router/session_state.dart';

final getIt = GetIt.instance;

/// Registers every shared object. Call once from `main()`, before `runApp`.
Future<void> setupInjection() async {
  final clientInfo = await ClientInfo.load();
  final securityContext = await RootCa.securityContext();

  getIt
    ..registerSingleton<ClientInfo>(clientInfo)
    ..registerLazySingleton<SessionState>(SessionState.new)
    ..registerLazySingleton<LocaleCubit>(LocaleCubit.new)
    ..registerLazySingleton<TokenStore>(InMemoryTokenStore.new)
    ..registerLazySingleton<DioClient>(
      () => DioClient(
        securityContext: securityContext,
        interceptors: [
          AuthInterceptor(getIt<TokenStore>(), getIt<SessionState>()),
          AppVersionInterceptor(clientInfo.appVersion, getIt<SessionState>()),
          ForbiddenInterceptor(getIt<TokenStore>(), getIt<SessionState>()),
          DeviceIdInterceptor(clientInfo.deviceId),
          IdempotencyInterceptor(),
        ],
      ),
    )
    ..registerLazySingleton<ConnectionCubit>(
      () =>
          ConnectionCubit(checkConnection: getIt<DioClient>().checkConnection),
    )
    ..registerLazySingleton<AppRouter>(() => AppRouter(getIt<SessionState>()));
}
