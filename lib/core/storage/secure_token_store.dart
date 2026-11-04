import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../network/token_store.dart';

/// The device token in the Android Keystore (flutter_secure_storage), so it
/// survives a restart. Kept in memory after the first read: every request
/// asks for it.
class SecureTokenStore implements TokenStore {
  SecureTokenStore(this._storage);

  final FlutterSecureStorage _storage;

  static const _keyName = 'device_token';

  String? _token;
  bool _loaded = false;

  @override
  Future<String?> read() async {
    if (_loaded) return _token;
    try {
      _token = await _storage.read(key: _keyName);
    } on Exception catch (e) {
      // An unreadable token counts as signed out: P-52 asks to sign in.
      debugPrint('SecureTokenStore: token unreadable ($e)');
      _token = null;
    }
    _loaded = true;
    return _token;
  }

  @override
  Future<void> save(String token) async {
    await _storage.write(key: _keyName, value: token);
    _token = token;
    _loaded = true;
  }

  @override
  Future<void> clear() async {
    _token = null;
    _loaded = true;
    await _storage.delete(key: _keyName);
  }
}
