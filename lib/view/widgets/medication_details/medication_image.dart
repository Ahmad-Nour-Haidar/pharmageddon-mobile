import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_svg.dart';
import '../custom_cached_network_image.dart';
import '../svg_image.dart';

class MedicationImage extends StatelessWidget {
  const MedicationImage({
    super.key,
    required this.isFav,
    required this.onTapFav,
  });

  final bool isFav;
  final void Function() onTapFav;

  @override
  Widget build(BuildContext context) {
    // todo
    // final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    // final tag = args.args[AppKeys.tag];
    final tag = UniqueKey();
    final width = AppSize.width * .8;
    final height = AppSize.width * .6;
    return Hero(
      tag: tag,
      child: Align(
        child: SizedBox(
          height: height + 21,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CustomCachedNetworkImage(
                width: width,
                height: height,
                imageUrl: '',
                errorWidget: ErrorWidgetShow.picture,
              ),
              Positioned.fill(
                bottom: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Material(
                    shape: const OvalBorder(),
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: onTapFav,
                      child: SizedBox(
                        height: 42,
                        width: 42,
                        child: Align(
                          child: SvgImage(
                            path: isFav ? AppSvg.heartFill : AppSvg.heart,
                            color: AppColor.red,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
