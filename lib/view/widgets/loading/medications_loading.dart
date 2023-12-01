import 'package:flutter/material.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/functions/functions.dart';
import 'custom_shimmer.dart';

class MedicationsLoading extends StatelessWidget {
  const MedicationsLoading({
    super.key,
    required this.onRefresh,
  });

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 20,
            runSpacing: 10,
            children: List.generate(
              getRandom(),
              (index) => CustomShimmer(
                child: Container(
                  height: AppSize.widthCard + 40,
                  width: AppSize.widthCard,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(AppSize.radius10),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
