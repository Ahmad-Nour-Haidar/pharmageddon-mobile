import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_svg.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/core/functions/navigator.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
import 'package:pharmageddon_mobile/routes.dart';
import 'custom_popup_menu_button.dart';

class CustomAppBar {
  const CustomAppBar({
    this.title = '',
    this.showArrowBack = true,
    this.showOptions = false,
    this.showSearch = false,
    this.showLogout = false,
    this.showCart = false,
    this.showOrders = false,
    this.showFavorites = false,
    this.showReports = false,
  });

  final String title;
  final bool showArrowBack;
  final bool showOptions;
  final bool showSearch;
  final bool showCart;
  final bool showOrders;
  final bool showFavorites;
  final bool showReports;
  final bool showLogout;

  AppBar build() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.transparent,
      centerTitle: true,
      leading: showArrowBack
          ? Builder(builder: (context) {
              return IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(
                    isEnglish() ? AppSvg.arrowLeft : AppSvg.arrowRight),
              );
            })
          : null,
      title: Text(
        title,
        style: AppTextTheme.f20w600black,
      ),
      actions: [
        if (showSearch)
          Builder(builder: (context) {
            return IconButton(
              onPressed: () => pushNamed(AppRoute.search, context),
              icon: SvgPicture.asset(AppSvg.search),
            );
          }),
        if (showOptions)
          CustomPopupMenuButton(
            showCart: showCart,
            showOrders: showOrders,
            showFavorites: showFavorites,
            showReports: showReports,
            showLogout: showLogout,
          ),
      ],
    );
  }
}
