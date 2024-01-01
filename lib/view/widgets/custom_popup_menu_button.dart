import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_size.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_text.dart';
import '../../core/constant/app_svg.dart';
import '../../core/functions/functions.dart';
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
    // required this.showLogout,
  });

  final bool showCart;
  final bool showOrders;
  final bool showFavorites;
  final bool showReports;

  // final bool showLogout;

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
      constraints: BoxConstraints(maxWidth: AppSize.width / 2),
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
            child: FittedBox(
              child: Row(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CustomCachedNetworkImage(
                      width: 60,
                      height: 60,
                      radius: 30,
                      imageUrl: getImageUserUrl(),
                      errorWidget: ErrorWidgetShow.user,
                    ),
                  ),
                  const Gap(20),
                  Text(
                    AppText.profile.tr,
                    style: AppTextStyle.f18w500black,
                  )
                ],
              ),
            ),
          ),
          if (showCart)
            PopupMenuItem(
              padding: AppPadding.screenPadding,
              value: AppRoute.cart,
              child: Text(
                AppText.cart.tr,
                style: AppTextStyle.f18w500black,
              ),
            ),
          if (showOrders)
            PopupMenuItem(
              padding: AppPadding.screenPadding,
              value: AppRoute.orders,
              child: Text(
                AppText.orders.tr,
                style: AppTextStyle.f18w500black,
              ),
            ),
          if (showFavorites)
            PopupMenuItem(
              padding: AppPadding.screenPadding,
              value: AppRoute.favorites,
              child: Text(
                AppText.favorite.tr,
                style: AppTextStyle.f18w500black,
              ),
            ),
          if (showReports)
            PopupMenuItem(
              padding: AppPadding.screenPadding,
              value: AppRoute.reports,
              child: Text(
                AppText.reports.tr,
                style: AppTextStyle.f18w500black,
              ),
            ),
          // if (showLogout)
          //   PopupMenuItem(
          //     padding: AppPadding.screenPadding,
          //     value: AppRoute.logout,
          //     child: Row(
          //       children: [
          //         Text(
          //           AppText.logOut.tr,
          //           style: AppTextStyle.f18w500black,
          //         ),
          //         const Spacer(),
          //         const SvgImage(
          //           path: AppSvg.exit,
          //           color: AppColor.primaryColor,
          //           size: 24,
          //         ),
          //       ],
          //     ),
          //   ),
        ];
      },
    );
  }
}
