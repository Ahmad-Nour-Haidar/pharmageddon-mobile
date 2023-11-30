import 'dart:math' as math;
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_size.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({
    super.key,
    required this.onChange,
    required this.list,
    required this.initialIndex,
  });

  final void Function(int index) onChange;
  final List<String> list;
  final int initialIndex;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late int index;

  @override
  void initState() {
    index = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: const EdgeInsets.only(top: 55),
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
            top: -35,
            left: 0,
            right: 0,
            child: Row(
              children: List.generate(
                widget.list.length,
                (index) => Expanded(
                  child: index == this.index
                      ? Align(
                          child: SlideInUp(
                            duration: const Duration(milliseconds: 300),
                            child: Transform.rotate(
                              angle: -math.pi / 4,
                              child: Container(
                                height: AppSize.width / 6,
                                width: AppSize.width / 6,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(8),
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
        ],
      ),
    );
  }
}
