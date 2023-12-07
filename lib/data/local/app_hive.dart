import 'package:hive_flutter/hive_flutter.dart';
import 'package:pharmageddon_mobile/print.dart';

class AppHive {
  static const _cartBox = 'cartBox';
  late final Box? _box;

  Future<void> initial() async {
    _box = await Hive.openBox(_cartBox);
    printme.magenta(_box?.length);
    printme.magenta(_box?.toMap());
    printme.magenta('initial AppHive');
  }

  Future<void> store({
    required String key,
    required dynamic value,
  }) async {
    await _box?.put(key, value);
    printme.magenta(_box?.length);
    printme.magenta('AppHive');
    printme.cyan(_box?.toMap());
  }
}
