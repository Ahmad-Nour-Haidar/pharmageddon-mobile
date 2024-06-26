import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_text.dart';
import 'package:pharmageddon_mobile/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/model/medication_model.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_cached_network_image.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_keys.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/functions/navigator.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../routes.dart';
import '../app_widget.dart';

class MedicationWidget extends StatelessWidget {
  const MedicationWidget({
    super.key,
    required this.model,
  });

  final MedicationModel model;

  @override
  Widget build(BuildContext context) {
    final tag = UniqueKey();
    return InkWell(
      onTap: () {
        pushNamed(AppRoute.medicineDetails, context, arguments: {
          AppKeys.medicationModel: model,
          AppKeys.tag: tag,
        });
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(AppSize.radius10),
        child: Container(
          padding: AppPadding.padding10,
          width: AppSize.widthCard,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(AppSize.radius10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Hero(
                    tag: tag,
                    child: CustomCachedNetworkImage(
                      width: AppSize.widthCard,
                      height: AppSize.widthCard,
                      radius: 10,
                      imageUrl: getUrlImageMedication(model),
                      errorWidget: ErrorWidgetShow.picture,
                    ),
                  ),
                  if (model.discount! > 0)
                    Positioned(
                      top: -20,
                      left: -20,
                      child: Transform.rotate(
                        angle: -pi / 4,
                        child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.bottomCenter,
                          padding: AppPadding.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: AppColor.red.withOpacity(.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FittedBox(
                            child: Text(
                              '${model.discount?.toInt()} %'.trn,
                              style: AppTextStyle.f20w600white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (isNew(model))
                    Positioned(
                      top: -20,
                      right: -20,
                      child: Transform.rotate(
                        angle: pi / 4,
                        child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.bottomCenter,
                          padding: AppPadding.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: AppColor.red.withOpacity(.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FittedBox(
                            child: Text(
                              AppText.newW.tr,
                              style: AppTextStyle.f20w600white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const Gap(10),
              AutoSizeText(
                getMCommercialName(model),
                style: AppTextStyle.f16w600black,
                maxLines: 1,
              ),
              const Gap(3),
              AutoSizeText(
                getManufacturerName(model.manufacturer),
                style: AppTextStyle.f15w400black,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MedicationsListWidget extends StatelessWidget {
  const MedicationsListWidget({
    super.key,
    required this.data,
    required this.onRefresh,
    required this.onEmpty,
  });

  final List<MedicationModel> data;
  final Future<void> Function() onRefresh;
  final Widget? onEmpty;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: data.isEmpty
            ? ListView(children: [
                Gap(AppSize.width / 2),
                onEmpty ?? AppInjection.getIt<AppWidget>().noData
              ])
            : ListView(
                padding: AppPadding.zero,
                children: [
                  Text(
                    '${AppText.all.tr} : ( ${data.length} )'.trn,
                    style: AppTextStyle.f18w500black,
                  ),
                  const Gap(5),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: List.generate(
                      data.length,
                      (index) => MedicationWidget(
                        model: data[index],
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
