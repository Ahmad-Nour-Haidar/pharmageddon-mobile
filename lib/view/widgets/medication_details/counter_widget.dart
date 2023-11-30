import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_svg.dart';
import '../../../core/resources/app_text_theme.dart';
import '../svg_image.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    super.key,
    required this.initialValue,
    required this.maxValue,
    required this.onChange,
  });

  final int initialValue, maxValue;
  final void Function(int counter) onChange;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late int counter;

  @override
  void initState() {
    counter = widget.initialValue;
    super.initState();
  }

  void change(int x) {
    if (counter + x < 0) return;
    if (counter + x > widget.maxValue) return;
    setState(() => counter += x);
    widget.onChange(counter);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topCenter,
        child: Material(
          color: AppColor.green2,
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: AppSize.width * 0.35,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () => change(-1),
                    child: const SizedBox(
                      height: 42,
                      width: 42,
                      child: Align(
                        child: SvgImage(
                          path: AppSvg.minus,
                          color: AppColor.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      counter.toString(),
                      style: AppTextTheme.f18w600white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () => change(1),
                    child: const SizedBox(
                      height: 42,
                      width: 42,
                      child: Align(
                        child: SvgImage(
                          path: AppSvg.plus,
                          color: AppColor.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
