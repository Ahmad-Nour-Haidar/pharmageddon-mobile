import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_padding.dart';
import '../../../core/constant/app_svg.dart';
import '../../../core/resources/app_text_theme.dart';

class CounterCartWidget extends StatefulWidget {
  const CounterCartWidget({
    super.key,
    required this.onChange,
    required this.initialValue,
    required this.maxValue,
  });

  final void Function(int newQuantity) onChange;
  final int initialValue;
  final int maxValue;

  @override
  State<CounterCartWidget> createState() => _CounterCartWidgetState();
}

class _CounterCartWidgetState extends State<CounterCartWidget> {
  static Timer? _timer;
  static const _duration = Duration(milliseconds: 100);
  late int quantity = 0;

  @override
  void initState() {
    quantity = widget.initialValue;
    super.initState();
  }

  void change(int x) {
    if (quantity + x < 1) return;
    if (quantity + x > widget.maxValue) return;
    quantity += x;
    widget.onChange(quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onLongPress: () {
            change(-1);
            _timer = Timer.periodic(_duration, (timer) => change(-1));
          },
          onLongPressEnd: (LongPressEndDetails details) {
            _timer?.cancel();
            _timer = null;
          },
          child: InkWell(
            onTap: () => change(-1),
            child: const Align(
              child: SvgImage(
                path: AppSvg.minus,
                color: AppColor.primaryColor,
                size: 30,
              ),
            ),
          ),
        ),
        Container(
          padding: AppPadding.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColor.primaryColor),
          ),
          child: Text(
            maxLines: 1,
            quantity.toString().trn,
            style: AppTextStyle.f16w600primaryColor,
            textAlign: TextAlign.center,
          ),
        ),
        GestureDetector(
          onTap: () => change(1),
          onLongPress: () {
            change(1);
            _timer = Timer.periodic(_duration, (timer) => change(1));
          },
          onLongPressEnd: (LongPressEndDetails details) {
            _timer?.cancel();
            _timer = null;
          },
          child: InkWell(
            onTap: () => change(1),
            child: const Align(
              child: SvgImage(
                path: AppSvg.plus,
                color: AppColor.primaryColor,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
