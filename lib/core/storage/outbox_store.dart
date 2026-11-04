import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive_ce.dart';

import '../models/outbox_event.dart';

/// The Outbox box: events saved on the device until the server answers
/// (MB-F3). Kept in the order they were saved. Logout and session expiry do
/// not touch it.
class OutboxStore {
  OutboxStore(this._box) {
    for (final entry in _box.toMap().entries) {
      final event = _decode(entry.value);
      if (event != null) _keys[event.clientEventId] = entry.key;
    }
  }

  static const boxName = 'outbox';

  final Box<String> _box;

  /// `client_event_id` → Hive key. Hive's own keys are auto-increment
  /// integers, which keep the Outbox order.
  final Map<String, dynamic> _keys = {};

  /// Fires when an event is added, changed or removed.
  Stream<void> get changes => _box.watch().map((_) {});

  /// Every event on the device, oldest first.
  List<OutboxEvent> get events => [
    for (final value in _box.values) ?_decode(value),
  ];

  Future<void> add(OutboxEvent event) async {
    _keys[event.clientEventId] = await _box.add(jsonEncode(event.toJson()));
  }

  /// Saves the new state of events already in the box. Unknown ids are
  /// ignored.
  Future<void> updateAll(Iterable<OutboxEvent> events) => _box.putAll({
    for (final event in events)
      if (_keys.containsKey(event.clientEventId))
        _keys[event.clientEventId]: jsonEncode(event.toJson()),
  });

  Future<void> update(OutboxEvent event) => updateAll([event]);

  /// Deletes the events that match [test] (the MB-F4A purge).
  Future<void> removeWhere(bool Function(OutboxEvent event) test) async {
    final ids = [
      for (final event in events)
        if (test(event)) event.clientEventId,
    ];
    await _box.deleteAll([for (final id in ids) _keys.remove(id)]);
  }

  Future<void> clear() async {
    _keys.clear();
    await _box.clear();
  }

  static OutboxEvent? _decode(String value) {
    try {
      return OutboxEvent.fromJson(jsonDecode(value) as Map<String, Object?>);
    } on Object catch (e) {
      debugPrint('OutboxStore: unreadable event skipped ($e)');
      return null;
    }
  }
}
