import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.isLoading,
    required this.onTap,
    required this.color,
    required this.text,
    required this.style,
    this.width = 70,
  });

  final bool isLoading;
  final void Function() onTap;
  final Color color;
  final TextStyle style;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: 40,
        width: width,
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
        width: width,
        child: Center(
          child: Text(text, style: style),
        ),
      ),
    );
  }
}
