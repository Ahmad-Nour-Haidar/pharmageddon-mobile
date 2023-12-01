import 'package:flutter/cupertino.dart';

class AppSize {
  AppSize._();

  static void initial(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    width = size.width;
    height = size.height;
    // card
    widthCard = ((width - 50) / 2);
    heightCard = widthCard + 60;
    widthManufacturer = (AppSize.width * .35).toInt() * 1.0;
    // radius = (AppSize.width / 2) - 50;
    // radiusImage = radius - 5;
    // widthHeight = radiusImage * 2;
  }

  // image
  static late double radius;
  static late double radiusImage;
  static late double widthHeight;

  // card
  static late double widthCard;
  static late double widthManufacturer;
  static late double heightCard;

  // size
  static late double width;
  static late double height;
  static const size10 = 10.0;
  static const size15 = 15.0;
  static const size20 = 20.0;
  static const size25 = 25.0;
  static const size30 = 30.0;
  static const size32 = 32.0;
  static const size40 = 40.0;
  static const size45 = 45.0;
  static const size50 = 50.0;
  static const size60 = 60.0;
  static const size70 = 70.0;
  static const size80 = 80.0;
  static const size100 = 100.0;
  static const size140 = 140.0;

  // padding
  static const padding5 = 5.0;
  static const padding10 = 10.0;
  static const padding15 = 15.0;
  static const padding20 = 20.0;
  static const padding25 = 25.0;
  static const padding30 = 30.0;
  static const padding40 = 40.0;
  static const padding60 = 60.0;
  static const screenPadding = padding15;

  // radius
  static const radius10 = 10.0;
  static const radius15 = 15.0;
  static const radius20 = 20.0;
  static const radius35 = 35.0;
  static const radius45 = 45.0;
  static const radius65 = 65.0;

  // elevation
  static const elevation4 = 4.0;
  static const elevation6 = 6.0;
}
