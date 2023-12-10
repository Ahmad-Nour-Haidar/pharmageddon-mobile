import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/functions/functions.dart';
import '../../../generate_material_color.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    required this.child,
    this.baseColor,
  });

  final Widget child;
  final Color? baseColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: isEnglish() ? ShimmerDirection.ltr : ShimmerDirection.rtl,
      baseColor: baseColor ?? AppColor.white,
      highlightColor: generateMaterialColor(color: AppColor.cardColor),
      child: child,
    );
  }
}
