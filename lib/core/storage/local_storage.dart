import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import 'encryption_key_store.dart';
import 'entity_cache.dart';
import 'meta_store.dart';
import 'outbox_store.dart';

/// The encrypted Hive boxes on the device (MB-F3). Every box is AES-256
/// encrypted with the key from [EncryptionKeyStore].
///
/// Hive encrypts the values, not the keys: box keys are record ids only,
/// never user data.
class LocalStorage {
  LocalStorage._({
    required this.outbox,
    required this.tasks,
    required this.notifications,
    required this.meta,
  });

  /// The layout of the boxes. Raise it when a record format changes.
  static const int schemaVersion = 1;

  static const _boxNames = [
    OutboxStore.boxName,
    EntityCache.tasksBoxName,
    EntityCache.notificationsBoxName,
    MetaStore.boxName,
  ];

  final OutboxStore outbox;
  final TaskCache tasks;
  final NotificationCache notifications;
  final MetaStore meta;

  /// Opens every box. Call once, before anything reads them. [path] is for
  /// tests; the app uses its own documents folder.
  static Future<LocalStorage> open(
    EncryptionKeyStore keys, {
    String? path,
  }) async {
    if (path == null) {
      await Hive.initFlutter();
    } else {
      Hive.init(path);
    }

    var key = await keys.read();
    if (key == null) {
      // First start, or the key is lost (app data restored without the
      // Keystore): boxes left on disk can never be read again.
      await _deleteBoxes();
      key = await keys.create();
    }
    final cipher = HiveAesCipher(key);

    final storage = LocalStorage._(
      outbox: OutboxStore(await _openBox(OutboxStore.boxName, cipher)),
      tasks: EntityCache.tasks(
        await _openBox(EntityCache.tasksBoxName, cipher),
      ),
      notifications: EntityCache.notifications(
        await _openBox(EntityCache.notificationsBoxName, cipher),
      ),
      meta: MetaStore(await _openBox(MetaStore.boxName, cipher)),
    );
    await storage._checkSchema();
    return storage;
  }

  /// A box that cannot be opened (damaged file) is deleted and made again
  /// empty: the server sends the cache again on the next sync.
  static Future<Box<String>> _openBox(String name, HiveCipher cipher) async {
    try {
      return await Hive.openBox<String>(name, encryptionCipher: cipher);
    } on Object catch (e) {
      debugPrint('LocalStorage: box "$name" unreadable, recreated ($e)');
      await Hive.deleteBoxFromDisk(name);
      return Hive.openBox<String>(name, encryptionCipher: cipher);
    }
  }

  static Future<void> _deleteBoxes() async {
    for (final name in _boxNames) {
      await Hive.deleteBoxFromDisk(name);
    }
  }

  Future<void> _checkSchema() async {
    final saved = meta.schemaVersion;
    if (saved != null && saved != schemaVersion) {
      // TODO(MB-F4A): migrate the Outbox when its record format changes.
      // The caches are refilled by the next sync.
      await clearCaches();
    }
    if (saved != schemaVersion) await meta.saveSchemaVersion(schemaVersion);
  }

  /// Empties the task and notification caches. The Outbox is kept.
  Future<void> clearCaches() async {
    await tasks.clear();
    await notifications.clear();
  }

  /// Empties every box, the Outbox too. Only for a reset of the device, never
  /// for logout (logout keeps pending events).
  Future<void> wipe() async {
    await outbox.clear();
    await clearCaches();
    await meta.clear();
    await meta.saveSchemaVersion(schemaVersion);
  }

  Future<void> close() => Hive.close();
}
