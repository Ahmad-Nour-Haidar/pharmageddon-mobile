import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_size.dart';
import '../../core/constant/app_strings.dart';
import '../../core/resources/app_text_theme.dart';

class CustomToggleButton extends StatelessWidget {
  const CustomToggleButton({
    super.key,
    required this.onTap,
    required this.isEmail,
  });

  final void Function(bool isEmail) onTap;
  final bool isEmail;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: AppColor.cardColor,
        borderRadius: BorderRadius.circular(AppSize.radius10),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => onTap(true),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: isEmail ? AppColor.white : AppColor.transparent,
                  borderRadius: BorderRadius.circular(AppSize.radius10),
                ),
                child: Center(
                  child: Text(
                    AppText.email.tr,
                    style: AppTextStyle.f20w400gray,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onTap(false),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: !isEmail ? AppColor.white : AppColor.transparent,
                  borderRadius: BorderRadius.circular(AppSize.radius10),
                ),
                child: Center(
                  child: Text(
                    AppText.phone.tr,
                    style: AppTextStyle.f20w400gray,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
