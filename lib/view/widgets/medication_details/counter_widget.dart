import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/extensions/translate_numbers.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_svg.dart';
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
  final _controller = TextEditingController();

  @override
  void initState() {
    _counter = widget.initialValue;
    _controller.text = widget.initialValue.toString();
    super.initState();
  }

  void change(int x) {
    if (_counter + x < 0) return;
    if (_counter + x > widget.maxValue) return;
    setState(() {
      _counter += x;
      _controller.text = _counter.toString().trNumber();
    });
    widget.onChange(_counter);
  }

  static const _border = OutlineInputBorder(
    gapPadding: 0,
    borderSide: BorderSide(color: AppColor.transparent),
  );

  void changeFromValue() {
    var x = int.tryParse(_controller.text) ?? 0;
    if (x < 0) x = 0;
    if (x > widget.maxValue) x = widget.maxValue;
    setState(() {
      _counter = x;
      _controller.text = _counter.toString().trNumber();
    });
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
                // Expanded(
                //   child: AutoSizeText(
                //     maxLines: 1,
                //     _counter.toString(),
                //     style: AppTextTheme.f18w600white,
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      // FilteringTextInputFormatter.deny(
                      //     RegExp(r'^([0-9]|[1-9][0-9]{0,2}|1000)$')),
                    ],
                    onFieldSubmitted: (_) => changeFromValue(),
                    onChanged: (_) => changeFromValue(),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    scrollPadding: AppPadding.zero,
                    textAlignVertical: TextAlignVertical.top,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(
                      color: AppColor.white,
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      border: _border,
                      focusedBorder: _border,
                      enabledBorder: _border,
                      constraints: BoxConstraints(maxHeight: 42),
                    ),
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
