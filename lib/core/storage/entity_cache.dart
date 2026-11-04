import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive_ce.dart';

import '../models/field_notification.dart';
import '../models/field_task.dart';

/// Cached tasks, keyed by `plan_component_id` (MB-F3).
typedef TaskCache = EntityCache<FieldTask>;

/// Cached notifications, keyed by notification id (MB-F3).
typedef NotificationCache = EntityCache<FieldNotification>;

/// A cache box of server records, one JSON record per id. Reads are
/// cache-first: screens show this until the next `GET /sync/changes`.
class EntityCache<T> {
  EntityCache(
    this._box, {
    required String Function(T item) idOf,
    required Map<String, Object?> Function(T item) toJson,
    required T Function(Map<String, Object?> json) fromJson,
  }) : _idOf = idOf,
       _toJson = toJson,
       _fromJson = fromJson;

  static const tasksBoxName = 'tasks';
  static const notificationsBoxName = 'notifications';

  static TaskCache tasks(Box<String> box) => EntityCache(
    box,
    idOf: (t) => t.id,
    toJson: (t) => t.toJson(),
    fromJson: FieldTask.fromJson,
  );

  static NotificationCache notifications(Box<String> box) => EntityCache(
    box,
    idOf: (n) => n.id,
    toJson: (n) => n.toJson(),
    fromJson: FieldNotification.fromJson,
  );

  final Box<String> _box;
  final String Function(T item) _idOf;
  final Map<String, Object?> Function(T item) _toJson;
  final T Function(Map<String, Object?> json) _fromJson;

  /// Fires when a record is saved or removed.
  Stream<void> get changes => _box.watch().map((_) {});

  List<T> get all => [for (final value in _box.values) ?_decode(value)];

  T? byId(String id) {
    final value = _box.get(id);
    return value == null ? null : _decode(value);
  }

  /// Saves or replaces each record by its id.
  Future<void> putAll(Iterable<T> items) => _box.putAll({
    for (final item in items) _idOf(item): jsonEncode(_toJson(item)),
  });

  Future<void> put(T item) => putAll([item]);

  /// Deletes records by id (the `removed` list of `GET /sync/changes`).
  Future<void> removeAll(Iterable<String> ids) => _box.deleteAll(ids);

  Future<void> clear() => _box.clear();

  T? _decode(String value) {
    try {
      return _fromJson(jsonDecode(value) as Map<String, Object?>);
    } on Object catch (e) {
      debugPrint('EntityCache<$T>: unreadable record skipped ($e)');
      return null;
    }
  }
}
