import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce/hive_ce.dart';

/// Keeps the AES-256 key of the Hive boxes in the Android Keystore
/// (flutter_secure_storage). The key is made once, on the first start.
class EncryptionKeyStore {
  EncryptionKeyStore(this._storage);

  final FlutterSecureStorage _storage;

  static const _keyName = 'hive_encryption_key';

  /// The saved key, or `null` when there is none or it cannot be read
  /// (the app data was restored without the Keystore, or the entry is
  /// damaged).
  Future<List<int>?> read() async {
    try {
      final value = await _storage.read(key: _keyName);
      if (value == null) return null;
      final key = base64Url.decode(value);
      return key.length == 32 ? key : null;
    } on Exception catch (e) {
      debugPrint('EncryptionKeyStore: key unreadable ($e)');
      return null;
    }
  }

  /// Makes a new random key and saves it, replacing any old one.
  Future<List<int>> create() async {
    final key = Hive.generateSecureKey();
    await _storage.write(key: _keyName, value: base64UrlEncode(key));
    return key;
  }
}
