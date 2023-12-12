import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_strings.dart';
import '../../core/resources/app_text_theme.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.isShow,
    required this.isLoading,
    required this.onTap,
    required this.color,
    required this.text,
    required this.style,
  });

  final bool isShow;
  final bool isLoading;
  final void Function() onTap;
  final Color color;
  final TextStyle style;
  final String text;

  @override
  Widget build(BuildContext context) {
    if (!isShow) return const SizedBox();
    if (isLoading) {
      return SizedBox(
        height: 40,
        width: 70,
        child: Center(
          child: SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(
              color: color,
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
        height: 40,
        width: 70,
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(text, style:style),
          ),
        ),
      ),
    );
  }
}
