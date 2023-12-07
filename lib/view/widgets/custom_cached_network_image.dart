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
    required this.imageUrl,
    required this.errorWidget,
  });

  final double width, height;
  final String imageUrl;
  final ErrorWidgetShow errorWidget;

  Widget get errorWidgetImp {
    late String path;
    if (errorWidget == ErrorWidgetShow.picture) {
      path = AppSvg.picture;
    } else {
      path = AppSvg.user;
    }
    final widget = Container(
      decoration: BoxDecoration(
        color: AppColor.gray4,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        child: SvgImage(
          path: path,
          color: AppColor.white,
          size: width / 2,
        ),
      ),
    );
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      httpHeaders: const {
        "Connection": "Keep-Alive",
        "Keep-Alive": "timeout=5",
      },
      width: width,
      height: height,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      fit: BoxFit.fitHeight,
      imageUrl: imageUrl,
      errorWidget: (context, url, error) {
        return errorWidgetImp;
      },
    );
  }
}
