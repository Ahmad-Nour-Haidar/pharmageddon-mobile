import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/print.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_size.dart';
import '../../core/functions/functions.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({
    super.key,
    required this.onChange,
    required this.list,
  });

  final void Function(int index) onChange;
  final List<String> list;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int index = 1;

  double get pos {
    final l = AppSize.width ~/ (widget.list.length * 2);
    printme.cyan('l = $l');
    return (index) * 2.0 * l + l / 2;
  }

  @override
  Widget build(BuildContext context) {
    printme.cyan(index);
    printme.cyan(pos);
    printme.cyan(AppSize.width);

    return Container(
      height: 75,
      margin: const EdgeInsets.only(top: 55),
      decoration: const BoxDecoration(
        color: AppColor.buttonColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -36,
            left: isEnglish() ? pos : null,
            right: isEnglish() ? null : pos,
            child: Transform.rotate(
              angle: -math.pi / 4,
              child: Container(
                height: (AppSize.width - 30) / widget.list.length,
                width: (AppSize.width - 30) / widget.list.length,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Align(
                  child: Container(
                    // height: 55,
                    // width: 55,
                    decoration: BoxDecoration(
                        color: AppColor.buttonColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Align(
                      child: SvgImage(
                        path: widget.list[index],
                        color: AppColor.white,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Row(
              children: List.generate(
                widget.list.length,
                (index) => Expanded(
                  child: index == this.index
                      ? const SizedBox()
                      : InkWell(
                          onTap: () {
                            setState(() {
                              this.index = index;
                            });
                            widget.onChange(index);
                          },
                          child: SizedBox(
                            height: 75,
                            child: Align(
                              child: SvgImage(
                                path: widget.list[index],
                                color: AppColor.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
