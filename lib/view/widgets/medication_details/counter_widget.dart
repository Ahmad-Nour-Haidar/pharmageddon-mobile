import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
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
  late int _counter;
  static Timer? _timer;
  static const _duration = Duration(milliseconds: 100);

  @override
  void initState() {
    _counter = widget.initialValue;
    super.initState();
  }

  void change(int x) {
    if (_counter + x < 0) return;
    if (_counter + x > widget.maxValue) return;
    setState(() => _counter += x);
    widget.onChange(_counter);
  }

  @override
  Widget build(BuildContext context) {
    final width = AppSize.width * 0.35;
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topCenter,
        child: Material(
          color: AppColor.green2,
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: width,
            child: Row(
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
                    child: SizedBox(
                      height: 42,
                      width: width * .3,
                      child: const Align(
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
                  child: AutoSizeText(
                    maxLines: 1,
                    _counter.toString(),
                    style: AppTextTheme.f18w600white,
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
                    child: SizedBox(
                      height: 42,
                      width: width * .3,
                      child: const Align(
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
