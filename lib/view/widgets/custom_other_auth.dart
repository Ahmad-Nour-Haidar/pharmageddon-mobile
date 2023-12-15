import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../core/constant/app_strings.dart';
import '../../core/constant/app_svg.dart';
import '../../core/resources/app_text_theme.dart';

class CustomOtherAuth extends StatelessWidget {
  const CustomOtherAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('-  ${AppText.or.tr}  -', style: AppTextStyle.f18w500black),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppSvg.google,
              width: 25,
              height: 25,
            ),
            const Gap(25),
            SvgPicture.asset(
              AppSvg.facebook,
              width: 25,
              height: 25,
            ),
          ],
        )
      ],
    );
  }
}
