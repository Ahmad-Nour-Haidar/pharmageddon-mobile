import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_svg.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';

class CustomAppBar {
  const CustomAppBar({
    this.keyScaffold,
    this.title = '',
    this.onTapBack,
    this.onTapOptions,
    this.onTapSearch,
    this.showArrowBack = true,
    this.showOptions = true,
    this.showOptionsLeading = false,
    this.showSearch = false,
    this.colorAppBar = AppColor.transparent,
  });

  final void Function()? onTapBack;
  final void Function()? onTapOptions;
  final void Function()? onTapSearch;
  final String title;
  final bool showArrowBack;
  final bool showOptions;
  final bool showOptionsLeading;
  final bool showSearch;
  final Color colorAppBar;
  final GlobalKey<ScaffoldState>? keyScaffold;

  AppBar build() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: colorAppBar,
      centerTitle: true,
      leading: showArrowBack
          ? IconButton(
              onPressed: onTapBack,
              icon: SvgPicture.asset(
                  isEnglish() ? AppSvg.arrowLeft : AppSvg.arrowRight),
            )
          : showOptionsLeading
              ? IconButton(
                  onPressed: () => keyScaffold?.currentState?.openDrawer(),
                  icon: SvgPicture.asset(AppSvg.options),
                )
              : null,
      title: Text(
        title,
        style: AppTextTheme.f20w600black,
      ),
      actions: [
        if (showSearch)
          IconButton(
            onPressed: onTapSearch,
            icon: SvgPicture.asset(AppSvg.search),
          ),
        if (showOptions && !showOptionsLeading)
          IconButton(
            onPressed: () => keyScaffold?.currentState?.openEndDrawer(),
            icon: SvgPicture.asset(AppSvg.options),
          ),
      ],
    );
  }
}
