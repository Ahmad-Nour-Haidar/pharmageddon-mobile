import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';

class CustomRowTextButton extends StatelessWidget {
  const CustomRowTextButton({
    super.key,
    required this.text,
    required this.btnText,
    required this.onTap,
  });

  final String text;
  final String btnText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: AppTextStyle.f16w600black,
          textAlign: TextAlign.center,
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            btnText,
            style: AppTextStyle.f16w600TextColor2,
          ),
        ),
      ],
    );
  }
}
