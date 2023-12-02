import 'package:flutter/cupertino.dart';
import 'package:pharmageddon_mobile/core/constant/app_size.dart';

abstract class AppPadding {
  static const screenPadding =
      EdgeInsets.symmetric(horizontal: AppSize.screenPadding);
  static const screenPaddingAll = EdgeInsets.all(AppSize.screenPadding);
  static const zero = EdgeInsets.all(0);
  static const padding5 = EdgeInsets.all(5);
  static const padding7 = EdgeInsets.all(7);
  static const padding10 = EdgeInsets.all(10);
  static const padding15 = EdgeInsets.all(15);
  static const padding20 = EdgeInsets.all(20);

  static EdgeInsets only({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);

  static EdgeInsets symmetric({
    double vertical = 0.0,
    double horizontal = 0.0,
  }) =>
      EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal);
}
