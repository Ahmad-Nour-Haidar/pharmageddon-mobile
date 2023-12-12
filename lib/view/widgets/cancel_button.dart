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
    return SizedBox(
      height: 40,
      child: !isShow
          ? null
          : isLoading
              ? const Align(
                  child: SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      color: AppColor.red,
                      strokeWidth: 3,
                    ),
                  ),
                )
              : TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: AppColor.red, padding: AppPadding.zero),
                  onPressed: onTap,
                  child: Text(AppStrings.cancel.tr,
                      style: AppTextTheme.f18w500red),
                ),
    );
  }
}
