import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_svg.dart';
import '../../core/resources/app_text_theme.dart';

class CounterCartWidget extends StatelessWidget {
  const CounterCartWidget({
    super.key,
    required this.onChange,
    required this.value,
  });

  final void Function(int change) onChange;
  final int value;
  static Timer? _timer;
  static const _duration = Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onLongPress: () {
            onChange(-1);
            _timer = Timer.periodic(_duration, (timer) => onChange(-1));
          },
          onLongPressEnd: (LongPressEndDetails details) {
            _timer?.cancel();
            _timer = null;
          },
          child: InkWell(
            onTap: () => onChange(-1),
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
            value.toString(),
            style: AppTextTheme.f16w600primaryColor,
            textAlign: TextAlign.center,
          ),
        ),
        GestureDetector(
          onTap: () => onChange(1),
          onLongPress: () {
            onChange(1);
            _timer = Timer.periodic(_duration, (timer) => onChange(1));
          },
          onLongPressEnd: (LongPressEndDetails details) {
            _timer?.cancel();
            _timer = null;
          },
          child: InkWell(
            onTap: () => onChange(1),
            child: const Align(
              child: SvgImage(
                path: AppSvg.plus,
                color: AppColor.primaryColor,
                size: 30,
              ),
            ),
          ),
        )
      ],
    );
  }
}
