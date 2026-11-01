import 'package:get_it/get_it.dart';

import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/data/mock_auth_repository.dart';
import '../../features/notifications/data/mock_notifications_repository.dart';
import '../../features/notifications/data/notifications_repository.dart';
import '../../features/sync/data/mock_outbox_repository.dart';
import '../../features/sync/data/outbox_repository.dart';
import '../../features/tasks/data/mock_tasks_repository.dart';
import '../../features/tasks/data/tasks_repository.dart';
import '../config/app_config.dart';
import '../localization/locale_cubit.dart';
import '../mock/mock_backend.dart';
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
      () => ConnectionCubit(
        checkConnection: AppConfig.useMockData
            // DEV-ONLY (Flutter Screens): the mock backend decides.
            ? () async => getIt<MockBackend>().online
            : getIt<DioClient>().checkConnection,
      ),
    )
    ..registerLazySingleton<AppRouter>(() => AppRouter(getIt<SessionState>()));

  _registerRepositories();
}

/// Repositories. Each MB task swaps its mock for the real one here.
void _registerRepositories() {
  // DEV-ONLY (Flutter Screens): every repository runs on the mock backend.
  final backend = MockBackend(getIt<SessionState>());
  getIt
    ..registerSingleton<MockBackend>(backend)
    ..registerLazySingleton<AuthRepository>(() => MockAuthRepository(backend))
    ..registerLazySingleton<TasksRepository>(
      () => MockTasksRepository(backend, getIt<SessionState>()),
    )
    ..registerLazySingleton<OutboxRepository>(
      () => MockOutboxRepository(backend),
    )
    ..registerLazySingleton<NotificationsRepository>(
      () => MockNotificationsRepository(backend, getIt<SessionState>()),
    );
  // The header connection follows the mock switch right away.
  backend.changes.listen((_) => getIt<ConnectionCubit>().recheck());
}
