/// Holds the device token issued at sign-in.
abstract interface class TokenStore {
  Future<String?> read();
  Future<void> save(String token);
  Future<void> clear();
}

/// DEV-ONLY(MB-F3): replaced by a flutter_secure_storage store so the token
/// survives a restart.
class InMemoryTokenStore implements TokenStore {
  String? _token;

  @override
  Future<String?> read() async => _token;

  @override
  Future<void> save(String token) async => _token = token;

  @override
  Future<void> clear() async => _token = null;
}
