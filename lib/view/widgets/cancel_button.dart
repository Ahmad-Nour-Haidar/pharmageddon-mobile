import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_strings.dart';
import '../../core/resources/app_text_theme.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    super.key,
    required this.isShow,
    required this.isLoading,
    required this.onTap,
  });

  final bool isShow;
  final bool isLoading;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    if (!isShow) return const SizedBox();
    if (isLoading) {
      return const SizedBox(
        height: 45,
        width: 70,
        child: Center(
          child: SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(
              color: AppColor.red,
              strokeWidth: 3,
            ),
          ),
        ),
      );
    }
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        height: 45,
        width: 90,
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child:
                Text(AppStrings.cancelOrder.tr, style: AppTextTheme.f18w500red),
          ),
        ),
      ),
    );
  }
}
