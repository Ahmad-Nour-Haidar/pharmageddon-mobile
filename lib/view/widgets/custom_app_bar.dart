import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_svg.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';

class CustomAppBar {
  const CustomAppBar({
    this.title = '',
    this.onTapBack,
    this.onTapOptions,
    this.showArrowBack = true,
    this.showOptions = true,
    this.colorAppBar = AppColor.transparent,
  });

  final void Function()? onTapBack;
  final void Function()? onTapOptions;
  final String title;
  final bool showArrowBack;
  final bool showOptions;
  final Color colorAppBar;

  AppBar build() {
    return AppBar(
      centerTitle: true,
      backgroundColor: colorAppBar,
      title: Text(
        title,
        style: AppTextTheme.f20w600black,
      ),
      leading: showArrowBack
          ? IconButton(
              onPressed: onTapBack,
              icon: SvgPicture.asset(
                  isEnglish() ? AppSvg.arrowLeft : AppSvg.arrowRight),
            )
          : null,
      actions: [
        if (showOptions)
          IconButton(
            onPressed: onTapOptions,
            icon: SvgPicture.asset(AppSvg.options),
          ),
      ],
    );
  }
}
