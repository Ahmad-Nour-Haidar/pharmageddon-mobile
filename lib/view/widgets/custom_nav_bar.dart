import 'dart:math' as math;

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_size.dart';
import '../../core/enums/screens.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({
    super.key,
    required this.onChange,
    required this.list,
    required this.initialScreen,
  });

  final void Function(ScreenShow currentScreen) onChange;
  final List<ScreenShow> list;
  final ScreenShow initialScreen;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late ScreenShow currentScreen;

  @override
  void initState() {
    currentScreen = widget.initialScreen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSize.width * 0.15;
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: AppColor.green2,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -(s / 2),
            left: 0,
            right: 0,
            child: Row(
              children: List.generate(
                widget.list.length,
                (index) => Expanded(
                  child: widget.list[index] == currentScreen
                      ? Align(
                          child: SlideInUp(
                            duration: const Duration(milliseconds: 200),
                            child: Transform.rotate(
                              angle: -math.pi / 4,
                              child: Container(
                                height: s,
                                width: s,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: AppPadding.padding7,
                                child: Align(
                                  child: Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                        color: AppColor.green2,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Align(
                                      child: SvgImage(
                                        path: widget.list[index].pathIcon,
                                        color: AppColor.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
              ),
            ),
          ),
          Row(
            children: List.generate(
              widget.list.length,
              (index) => Expanded(
                child: widget.list[index] == currentScreen
                    ? const SizedBox()
                    : InkWell(
                        onTap: () {
                          setState(() {
                            currentScreen = widget.list[index];
                          });
                          widget.onChange(widget.list[index]);
                        },
                        child: Align(
                          child: SvgImage(
                            path: widget.list[index].pathIcon,
                            color: AppColor.white,
                            size: s / 2,
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
