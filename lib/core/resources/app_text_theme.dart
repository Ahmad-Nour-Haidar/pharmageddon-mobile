import 'package:flutter/material.dart';
import '../constant/app_color.dart';

abstract class AppTextTheme {
  static TextStyle get f18w500black => const TextStyle(
        fontSize: 18,
        color: AppColor.black,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get hintStyle => const TextStyle(
        fontSize: 16,
        color: AppColor.white,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get f20w600black => const TextStyle(
        fontSize: 20,
        color: AppColor.black,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get f20w400gray => const TextStyle(
        fontSize: 20,
        color: AppColor.gray,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get f18w400gray => const TextStyle(
        fontSize: 18,
        color: AppColor.gray,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get f16w600TextColor2 => const TextStyle(
        fontSize: 16,
        color: AppColor.textColor,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get f16w600black => const TextStyle(
        fontSize: 16,
        color: AppColor.black,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get f14w600black => const TextStyle(
        fontSize: 14,
        color: AppColor.black,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get f24w600black => const TextStyle(
        fontSize: 24,
        color: AppColor.black,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get f24w600white => const TextStyle(
        fontSize: 24,
        color: AppColor.white,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0,
      );

  static TextStyle get f26w600black => const TextStyle(
        fontSize: 26,
        color: AppColor.black,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get f26w600white => const TextStyle(
        fontSize: 26,
        color: AppColor.white,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get f28w700black => const TextStyle(
        fontSize: 28,
        color: AppColor.black,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get f16w400gray2 => const TextStyle(
        fontSize: 16,
        color: AppColor.gray2,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get f15w400black => const TextStyle(
    fontSize: 15,
    color: AppColor.black,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get f24w600SecondColor => const TextStyle(
        fontSize: 24.0,
        color: AppColor.secondColor,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get f32w600black => const TextStyle(
        fontSize: 32.0,
        color: AppColor.black,
        fontWeight: FontWeight.w600,
      );
}
