import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../core/constant/app_svg.dart';
import '../../core/resources/app_text_theme.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SvgPicture.asset(
            AppSvg.logo,
            width: 150,
            height: 150,
          ),
        ),
        const Gap(20),
        const Center(
          child: Text(
            'Pharmageddon',
            style: AppTextTheme.f24w600SecondColor,
          ),
        ),
      ],
    );
  }
}
