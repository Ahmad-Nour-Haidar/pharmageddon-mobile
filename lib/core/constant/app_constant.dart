import 'package:flutter/widgets.dart';
import 'package:pharmageddon_mobile/core/enums/screens.dart';

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
    ScreenShow.medications,
    ScreenShow.manufacturer,
    ScreenShow.effect,
    ScreenShow.discount,
  ];

  static const ordersList = [
    ScreenShow.preparing,
    ScreenShow.hasBeenSent,
    ScreenShow.received,
  ];
}
