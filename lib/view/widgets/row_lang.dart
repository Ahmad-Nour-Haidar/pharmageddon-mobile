import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/local_controller.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_constant.dart';
import '../../core/constant/app_size.dart';
import '../../core/constant/app_strings.dart';
import '../../core/functions/functions.dart';
import '../../core/resources/app_text_theme.dart';
import '../../core/services/dependency_injection.dart';
import 'custom_button.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppInjection.getIt<LocaleController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.language.tr,
          style: AppTextTheme.f20w600black,
        ),
        CustomButton(
          onTap: () => controller.changeLang(AppConstant.ar),
          text: AppStrings.arabic.tr,
          width: AppSize.width * .24,
          height: 40,
          color: isEnglish() ? AppColor.cardColor : AppColor.green2,
          textStyle: AppTextTheme.f20w600black,
        ),
        CustomButton(
          onTap: () => controller.changeLang(AppConstant.en),
          text: AppStrings.english.tr,
          width: AppSize.width * .24,
          height: 40,
          color: isEnglish() ? AppColor.green2 : AppColor.white,
          textStyle: AppTextTheme.f20w600black,
        ),
      ],
    );
  }
}
