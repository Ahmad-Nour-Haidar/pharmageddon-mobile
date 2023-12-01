import 'package:flutter/material.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/functions/functions.dart';
import 'custom_shimmer.dart';

class ManufacturersLoading extends StatelessWidget {
  const ManufacturersLoading({
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
            Wrap(
              alignment: WrapAlignment.center,
            spacing: 50,
              runSpacing: 20,
              children: List.generate(
                getRandom(),
                (index) => CustomShimmer(
                  child: Container(
                    height: 100,
                    width: AppSize.widthManufacturer,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(AppSize.radius10),
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
