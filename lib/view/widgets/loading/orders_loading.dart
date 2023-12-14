import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/functions/functions.dart';
import 'custom_shimmer.dart';

class OrdersLoading extends StatelessWidget {
  const OrdersLoading({
    super.key,
    required this.onRefresh,
  });

  final Future<void> Function() onRefresh;
  static final _random = Random();

  double get width => min(
        _random.nextInt(AppSize.width.toInt() - 150) + 120.0,
        AppSize.width - 100,
      );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: AppPadding.screenPaddingAll,
        itemBuilder: (context, index) {
          return Container(
            padding: AppPadding.padding10,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(AppSize.radius10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                3,
                (index) => CustomShimmer(
                  baseColor: AppColor.background,
                  child: Container(
                    margin: AppPadding.padding5,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: width,
                    child: const Text(''),
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Gap(10),
        itemCount: getRandom(),
      ),
    );
  }
}
