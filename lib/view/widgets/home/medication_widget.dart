import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/model/medication_model.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_cached_network_image.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_keys.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/functions/navigator.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../model/screen_arguments.dart';
import '../../../routes.dart';

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
        pushNamed(AppRoute.medicineDetails, context,
            arguments: ScreenArguments({
              // todo:
              AppKeys.medicationModel: model,
              AppKeys.tag: tag,
            }));
      },
      child: Container(
        width: AppSize.widthCard,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(AppSize.radius10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const Gap(10),
            Padding(
              padding: AppPadding.symmetric(horizontal: 10),
              child: AutoSizeText(
                getMedicationCommercialName(model),
                style: AppTextTheme.f15w400black,
                maxLines: 1,
              ),
            ),
            const Gap(3),
            Padding(
              padding: AppPadding.symmetric(horizontal: 10),
              child: AutoSizeText(
                getManufacturerName(model.manufacturer),
                style: AppTextTheme.f15w400black,
                maxLines: 1,
              ),
            ),
            const Gap(10),
          ],
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
        child: ListView(
          children: [
            Wrap(
              spacing: 20,
              runSpacing: 10,
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
