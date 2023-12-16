import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_text.dart';
import 'package:pharmageddon_mobile/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
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
    _controller.text = _counter.toString();
    super.initState();
  }

  void change(int x) {
    if (_counter + x < 0) return;
    if (_counter + x > widget.maxValue) return;
    setState(() {
      _counter += x;
      _controller.text = _counter.toString();
    });
    widget.onChange(_counter);
  }

  static const _border = OutlineInputBorder(
    gapPadding: 10,
    borderSide: BorderSide(
      color: AppColor.secondColor,
      width: 2,
    ),
  );

  void changeFromValue(String? value) {
    var x = int.tryParse(value ?? '') ?? 0;
    if (x < 0) x = 0;
    if (x > widget.maxValue) x = widget.maxValue;
    setState(() {
      _counter = x;
      _controller.text = _counter.toString();
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
                Expanded(
                  child: InkWell(
                    onTap: () => showAwesome(context),
                    child: SizedBox(
                      height: 42,
                      child: Center(
                        child: AutoSizeText(
                          maxLines: 1,
                          _counter.toString().trn,
                          style: AppTextStyle.f18w600white,
                        ),
                      ),
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

  void showAwesome(BuildContext context) {
    AwesomeDialog(
      bodyHeaderDistance: 0.0,
      padding: AppPadding.padding15,
      context: context,
      dialogType: DialogType.noHeader,
      body: Column(
        children: [
          Text(
            AppText.enterTheQuantityYouWant.tr,
            style: AppTextStyle.f18w600black,
          ),
          const Gap(15),
          TextField(
            autofocus: true,
            controller: _controller,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              // FilteringTextInputFormatter.deny(
              //     RegExp(r'^([0-9]|[1-9][0-9]{0,2}|1000)$')),
            ],
            // onFieldSubmitted: (_) => changeFromValue(_),
            onChanged: (_) => changeFromValue(_),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            scrollPadding: AppPadding.zero,
            textAlignVertical: TextAlignVertical.top,
            textInputAction: TextInputAction.done,
            style: AppTextStyle.f18w600black,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              border: _border,
              focusedBorder: _border,
              enabledBorder: _border,
              constraints: BoxConstraints(maxHeight: 42),
            ),
          ),
        ],
      ),
    ).show();
  }
}
