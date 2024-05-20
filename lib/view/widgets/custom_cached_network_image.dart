import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_svg.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';

enum ErrorWidgetShow { user, picture }

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.width,
    required this.height,
    required this.radius,
    required this.imageUrl,
    required this.errorWidget,
  });

  final double width, height, radius;
  final String imageUrl;
  final ErrorWidgetShow errorWidget;

  Widget get errorWidgetImp {
    final path =
        errorWidget == ErrorWidgetShow.picture ? AppSvg.picture : AppSvg.user;
    final widget = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColor.gray4,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Align(
        child: SvgImage(
          path: path,
          color: AppColor.white,
          size: min(width / 2, height / 2),
        ),
      ),
    );
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl.endsWith('null')) {
      return errorWidgetImp;
    }
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: CachedNetworkImage(
        httpHeaders: const {
          "Connection": "Keep-Alive",
          "Keep-Alive": "timeout=5",
        },
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        fit: BoxFit.cover,
        width: width,
        height: height,
        imageUrl: imageUrl,
        errorWidget: (context, url, error) {
          return errorWidgetImp;
        },
      ),
    );
  }
}
