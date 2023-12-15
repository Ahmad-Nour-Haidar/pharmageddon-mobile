import 'package:pharmageddon_mobile/core/constant/app_request_keys.dart';
import 'package:pharmageddon_mobile/core/constant/app_storage_keys.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/data/local/app_hive.dart';

class CartQuantityData {
  CartQuantityData._();

  final Map<int, int> _cart = {};
  final _appHive = AppInjection.getIt<AppHive>();

  static Future<CartQuantityData> getInstance() async {
    final cartQuantityData = CartQuantityData._();
    await cartQuantityData._initial();
    return cartQuantityData;
  }

  Future<void> _initial() async {
    final Map? map = _appHive.get(AppSKeys.cartKey) ?? {};
    map?.forEach((key, value) {
      _cart[key] = value;
    });
    // printme.magenta(_cart);
  }

  Future<void> storeInCart(int? key, int value) async {
    if (key == null) return;
    if (value == 0) {
      _cart.removeWhere((k, v) => k == key);
    } else {
      _cart[key] = value;
    }
    _appHive.store(AppSKeys.cartKey, _cart);
  }

  Future<void> deleteAllCart() async {
    _cart.clear();
    _appHive.store(AppSKeys.cartKey, _cart);
  }

  int getQuantityOfModel(int? id) {
    if (id == null) return 0;
    return _cart[id] ?? 0;
  }

  Future<Map<String, List<Map<String, int>>>> dataToRequest() async {
    final List<Map<String, int>> list = _cart.entries.map((entry) {
      return {
        AppRKeys.medicine_id: entry.key,
        // todo
        AppRKeys.quantity: 121212,
      };
    }).toList();
    final data = {AppRKeys.medicines: list};
    return data;
  }

  List<int> getIds() {
    return _cart.keys.toList();
  }
}
