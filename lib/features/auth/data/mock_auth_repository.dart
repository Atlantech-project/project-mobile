// DEV-ONLY (Flutter Screens): replaced by the real repository in MB-P53/P52.
import '../../../core/mock/mock_backend.dart';
import '../../../core/models/field_user.dart';
import '../../../core/models/port_info.dart';
import 'auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  MockAuthRepository(this._backend);

  final MockBackend _backend;

  @override
  Future<PortInfo> identifyPort() => _backend.identifyPort();

  @override
  Future<FieldUser> login({
    required String username,
    required String password,
  }) => _backend.login(username, password);

  @override
  Future<FieldUser> changePassword(String newPassword) =>
      _backend.changePassword(newPassword);

  @override
  Future<void> logout() => _backend.logout();
}
