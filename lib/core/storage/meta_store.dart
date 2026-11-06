import 'dart:convert';

import 'package:hive_ce/hive_ce.dart';

import '../models/field_user.dart';
import '../models/outbox_event.dart';

/// The meta box: small device values that are not server records (MB-F3).
///
/// Later tasks add their own keys here: the port from `GET /system/info`
/// (MB-P53) and the `sync_token` (MB-F4B).
class MetaStore {
  MetaStore(this._box);

  static const boxName = 'meta';

  static const _schemaVersion = 'schema_version';
  static const _deviceClass = 'device_class';
  static const _sessionUser = 'session_user';
  static const _lastUser = 'last_user';

  final Box<String> _box;

  /// The storage layout version the boxes were written with.
  int? get schemaVersion => int.tryParse(_box.get(_schemaVersion) ?? '');

  Future<void> saveSchemaVersion(int version) =>
      _box.put(_schemaVersion, '$version');

  /// `TABLET` or `MOBILE`, detected once on the first start. Sent as
  /// `sync_source` with every event.
  SyncSource? get deviceClass => SyncSource.fromCode(_box.get(_deviceClass));

  Future<void> saveDeviceClass(SyncSource value) =>
      _box.put(_deviceClass, value.code);

  /// The signed-in user (MB-P52). `null` when signed out.
  FieldUser? get sessionUser => _readUser(_sessionUser);

  /// The user of the last session, kept after sign-out for the same-user
  /// Outbox rule.
  FieldUser? get lastUser => _readUser(_lastUser);

  /// Saves the signed-in user; it also becomes [lastUser].
  Future<void> saveSessionUser(FieldUser user) {
    final value = jsonEncode(user.toJson());
    return _box.putAll({_sessionUser: value, _lastUser: value});
  }

  /// Sign-out and session expiry: forgets the signed-in user, keeps
  /// [lastUser].
  Future<void> clearSessionUser() => _box.delete(_sessionUser);

  FieldUser? _readUser(String key) {
    final value = _box.get(key);
    if (value == null) return null;
    return FieldUser.fromJson(jsonDecode(value) as Map<String, Object?>);
  }

  /// Removes everything except the device class, which belongs to the
  /// hardware.
  Future<void> clear() async {
    final deviceClass = _box.get(_deviceClass);
    await _box.clear();
    if (deviceClass != null) await _box.put(_deviceClass, deviceClass);
  }
}
