import 'package:hive_flutter/hive_flutter.dart';

class AppHive {
  AppHive._();

  static const _storageBox = '_storageBox';
  late final Box? _box;

  static Future<AppHive> getInstance() async {
    final appHive = AppHive._();
    await appHive._initial();
    return appHive;
  }

  Future<void> _initial() async {
    _box = await Hive.openBox(_storageBox);
    // printme.magenta(_box?.length);
    // printme.magenta(_box?.toMap());
    // printme.magenta('initial AppHive');
  }

  Future<void> store(String key, dynamic value) async {
    await _box?.put(key, value);
    // printme.magenta(_box?.length);
    // printme.magenta(_box?.toMap());
    // printme.magenta(_box?.get(AppSKeys.cartKey));
    // printme.magenta('store');
  }

  dynamic get(String key) {
    final value = _box?.get(key);
    // printme.magenta(_box?.length);
    // printme.cyan(_box?.toMap());
    // printme.magenta('get');
    return value;
  }

  Future<void> delete(String key) async {
    await _box?.delete(key);
    // printme.magenta(_box?.length);
    // printme.cyan(_box?.toMap());
    // printme.magenta('delete');
  }
}
