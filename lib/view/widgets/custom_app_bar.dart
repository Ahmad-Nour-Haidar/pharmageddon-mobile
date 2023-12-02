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
    this.onTapSearch,
    this.showArrowBack = true,
    this.showOptions = true,
    this.showSearch = false,
    this.colorAppBar = AppColor.transparent,
  });

  final void Function()? onTapBack;
  final void Function()? onTapOptions;
  final void Function()? onTapSearch;
  final String title;
  final bool showArrowBack;
  final bool showOptions;
  final bool showSearch;
  final Color colorAppBar;

  AppBar build() {
    return AppBar(
      centerTitle: true,
      backgroundColor: colorAppBar,
      actions: [
        if (showArrowBack)
        IconButton(
          onPressed: onTapBack,
          icon: SvgPicture.asset(
              isEnglish() ? AppSvg.arrowLeft : AppSvg.arrowRight),
        ),
        if (showOptions)
          IconButton(
            onPressed: onTapOptions,
            icon: SvgPicture.asset(AppSvg.options),
          ),
        const Spacer(),
        Text(
          title,
          style: AppTextTheme.f20w600black,
        ),
        const Spacer(),
        if (showSearch)
        IconButton(
          onPressed: onTapSearch,
          icon: SvgPicture.asset(AppSvg.search),
        ),
      ],
    );
  }
}
