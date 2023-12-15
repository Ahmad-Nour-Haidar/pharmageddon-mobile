import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
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
                    child: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                      ),
                      child: CustomCachedNetworkImage(
                        width: AppSize.widthCard,
                        height: AppSize.widthCard,
                        imageUrl: getUrlImageMedication(model),
                        errorWidget: ErrorWidgetShow.picture,
                      ),
                    ),
                  ),
                  if (model.discount! > 0)
                    Positioned(
                      top: 12,
                      left: -5,
                      child: Transform.rotate(
                        angle: -pi / 4,
                        child: Container(
                          padding: AppPadding.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: AppColor.red.withOpacity(.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${model.discount} %',
                            style: AppTextStyle.f18w500white,
                          ),
                        ),
                      ),
                    )
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
  });

  final List<MedicationModel> data;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: data.isEmpty
            ? ListView(children: [
                const Gap(100),
                AppInjection.getIt<AppWidget>().noData
              ])
            : ListView(
                children: [
                  Padding(
                    padding: AppPadding.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      '${AppText.all.tr} : ( ${data.length} )',
                      style: AppTextStyle.f18w500black,
                    ),
                  ),
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
