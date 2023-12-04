import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_strings.dart';
import '../../core/constant/app_svg.dart';
import '../../core/functions/navigator.dart';
import '../../core/resources/app_text_theme.dart';
import '../../routes.dart';
import 'custom_cached_network_image.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({
    super.key,
    required this.showCart,
    required this.showOrders,
    required this.showFavorites,
    required this.showReports,
    required this.showLogout,
  });

  final bool showCart;
  final bool showOrders;
  final bool showFavorites;
  final bool showReports;
  final bool showLogout;

  void onSelected(String value, BuildContext context) {
    if (value == AppRoute.logout) {
      return;
    }
    pushNamed(value, context);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: SvgPicture.asset(AppSvg.options),
      offset: const Offset(0, 0),
      color: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onSelected: (route) => onSelected(route, context),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            padding: AppPadding.screenPaddingAll,
            value: AppRoute.profile,
            child: Row(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const CustomCachedNetworkImage(
                    width: 60,
                    height: 60,
                    imageUrl: '',
                    errorWidget: ErrorWidgetShow.user,
                  ),
                ),
                const Gap(20),
                Text(
                  AppStrings.profile.tr,
                  style: AppTextTheme.f18w500black,
                )
              ],
            ),
          ),
          if (showCart)
            PopupMenuItem(
              padding: AppPadding.screenPadding,
              value: AppRoute.cart,
              child: Text(
                AppStrings.cart.tr,
                style: AppTextTheme.f18w500black,
              ),
            ),
          if (showOrders)
            PopupMenuItem(
              padding: AppPadding.screenPadding,
              value: AppRoute.orders,
              child: Text(
                AppStrings.orders.tr,
                style: AppTextTheme.f18w500black,
              ),
            ),
          if (showFavorites)
            PopupMenuItem(
              padding: AppPadding.screenPadding,
              value: AppRoute.favorites,
              child: Text(
                AppStrings.favorite.tr,
                style: AppTextTheme.f18w500black,
              ),
            ),
          if (showReports)
            PopupMenuItem(
              padding: AppPadding.screenPadding,
              value: AppRoute.reports,
              child: Text(
                AppStrings.reports.tr,
                style: AppTextTheme.f18w500black,
              ),
            ),
          if (showLogout)
            PopupMenuItem(
              padding: AppPadding.screenPadding,
              value: AppRoute.logout,
              child: Row(
                children: [
                  Text(
                    AppStrings.logOut.tr,
                    style: AppTextTheme.f18w500black,
                  ),
                  const Spacer(),
                  const SvgImage(
                    path: AppSvg.exit,
                    color: AppColor.primaryColor,
                    size: 24,
                  ),
                ],
              ),
            ),
        ];
      },
    );
  }
}
