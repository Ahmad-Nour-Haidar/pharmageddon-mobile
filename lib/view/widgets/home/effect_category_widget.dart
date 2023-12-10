import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmageddon_mobile/core/constant/app_link.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/model/effect_category_model.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_cached_network_image.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_keys.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/functions/navigator.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../model/screen_arguments.dart';
import '../../../routes.dart';
import '../app_widget.dart';

class EffectCategoryWidget extends StatelessWidget {
  const EffectCategoryWidget({
    super.key,
    required this.model,
  });

  final EffectCategoryModel model;

  String get url {
    final s = '${AppLink.categoriesImage}/${model.imageName}';
    return s;
  }

  @override
  Widget build(BuildContext context) {
    final tag = UniqueKey();
    return InkWell(
      onTap: () {
        pushNamed(AppRoute.effectMedicinesScreen, context,
            arguments: ScreenArguments({
              AppKeys.effectModel: model,
              AppKeys.tag: tag,
            }));
      },
      child: Material(
        borderRadius: BorderRadius.circular(AppSize.radius10),
        elevation: 4,
        child: Container(
          padding: AppPadding.padding10,
          width: AppSize.widthManufacturer,
          height: AppSize.widthManufacturer + 70,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(AppSize.radius10)),
          child: Column(
            children: [
              Hero(
                tag: tag,
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(2),
                    bottomRight: Radius.circular(2),
                  ),
                  child: CustomCachedNetworkImage(
                    width: AppSize.widthManufacturer,
                    height: AppSize.widthManufacturer - 30,
                    imageUrl: url,
                    errorWidget: ErrorWidgetShow.picture,
                  ),
                ),
              ),
              const Gap(5),
              const Divider(
                thickness: 2,
                color: AppColor.gray1,
              ),
              Expanded(
                child: Text(
                  getEffectCategoryModelName(model),
                  style: AppTextTheme.f20w600black,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EffectCategoriesListWidget extends StatelessWidget {
  const EffectCategoriesListWidget({
    super.key,
    required this.data,
    required this.onRefresh,
  });

  final List<EffectCategoryModel> data;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: data.isEmpty
          ? AppInjection.getIt<AppWidget>().noData
          : RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView(
                children: [
                  Center(
                    child: Wrap(
                      spacing: 30,
                      runSpacing: 20,
                      children: List.generate(
                        data.length,
                        (index) => EffectCategoryWidget(
                          model: data[index],
                        ),
                      ),
                    ),
                  ),
                  const Gap(30),
                ],
              ),
            ),
    );
  }
}
