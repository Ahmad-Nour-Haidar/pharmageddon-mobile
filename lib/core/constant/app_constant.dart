import 'package:flutter/widgets.dart';

import 'app_svg.dart';

class AppConstant {
  AppConstant._();

  static const ar = 'ar';
  static const en = 'en';
  static const pharmacist = 'pharmacist';

  // static const warehouseowner = 'warehouseowner';

  static const localEn = Locale(en);
  static const localAr = Locale(ar);
  static late Locale currentLocal;

  static const homeList = [
    AppSvg.text,
    AppSvg.all,
    AppSvg.chemistry,
    AppSvg.chemistry,
    AppSvg.chemistry
  ];
}
