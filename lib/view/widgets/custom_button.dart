import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_size.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.textStyle = AppTextStyle.f20w600white,
    this.height = 55,
    this.width = double.infinity,
    this.radius = AppSize.radius10,
    this.color = AppColor.buttonColor,
  });

  final void Function() onTap;
  final String text;
  final double height;
  final double width;
  final double radius;
  final Color color;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
        child: Center(
          child: Text(text, style: textStyle),
        ),
      ),
    );
  }
}
