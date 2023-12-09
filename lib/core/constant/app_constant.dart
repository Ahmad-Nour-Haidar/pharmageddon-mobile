import 'package:flutter/widgets.dart';

import 'app_svg.dart';

class AppConstant {
  AppConstant._();

  static const ar = 'ar';
  static const en = 'en';
  static const pharmacist = 'pharmacist';
  static const received = 'received';
  static const hasBeenSent = 'has_been_sent';
  static const preparing = 'preparing';

  static const localEn = Locale(en);

  // static const localAr = Locale(ar);

  static const homeList = [
    AppSvg.text,
    AppSvg.all,
    AppSvg.chemistry,
  ];

  static const ordersList = [
    AppSvg.boxCircleCheck,
    AppSvg.sent,
    AppSvg.boxOpen,
  ];
}
