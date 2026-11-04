/// Holds the device token issued at sign-in. The app uses
/// `SecureTokenStore` (`core/storage/`, MB-F3).
abstract interface class TokenStore {
  Future<String?> read();
  Future<void> save(String token);
  Future<void> clear();
}
