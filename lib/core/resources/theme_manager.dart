import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/app_color.dart';

ThemeData themeData() => ThemeData(
      applyElevationOverlayColor: false,
      fontFamily: 'Inter',
      useMaterial3: true,
      scaffoldBackgroundColor: AppColor.background,
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColor.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      primaryColor: AppColor.primaryColor,
      // colorScheme: ColorScheme.fromSwatch(
      //   primarySwatch: generateMaterialColor(color: AppColor.primaryColor),
      //   backgroundColor: AppColor.white,
      // ),
    );
