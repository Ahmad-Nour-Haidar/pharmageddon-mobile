import 'package:flutter/material.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/functions/functions.dart';
import 'custom_shimmer.dart';

class EffectCategoryLoading extends StatelessWidget {
  const EffectCategoryLoading({
    super.key,
    required this.onRefresh,
  });

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          children: [
            Center(
              child: Wrap(
                spacing: 50,
                runSpacing: 20,
                children: List.generate(
                  // test
                  getRandom(),
                  (index) => CustomShimmer(
                    child: Container(
                      height: AppSize.widthManufacturer + 30,
                      width: AppSize.widthManufacturer,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(AppSize.radius10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
