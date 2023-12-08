import 'package:pharmageddon_mobile/core/constant/app_storage_keys.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/data/local/app_hive.dart';

class CartQuantityData {
  CartQuantityData._();

  final Map<String, int> _cart = {};
  final _appHive = AppInjection.getIt<AppHive>();

  static Future<CartQuantityData> getInstance() async {
    final cartQuantityData = CartQuantityData._();
    await cartQuantityData._initial();
    return cartQuantityData;
  }

  Future<void> _initial() async {
    final Map? map = _appHive.get(AppSKeys.cartKey) ?? {};
    map?.forEach((key, value) {
      _cart[key.toString()] = value;
    });
  }

  Future<void> store(int? key, int value) async {
    if (key == null) return;
    if (value == 0) {
      _cart.removeWhere((k, v) => k == key.toString());
    } else {
      _cart[key.toString()] = value;
    }
    _appHive.store(AppSKeys.cartKey, _cart);
  }

  Future<void> deleteAllCart() async {
    _cart.clear();
    _appHive.store(AppSKeys.cartKey, _cart);
  }

  int getQuantityOfModel(int? id) {
    if (id == null) return 0;
    final q = _cart[id.toString()] ?? 0;
    return q;
  }
}
