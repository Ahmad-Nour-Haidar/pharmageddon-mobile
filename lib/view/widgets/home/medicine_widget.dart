import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_cached_network_image.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_keys.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/functions/navigator.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../model/screen_arguments.dart';
import '../../../routes.dart';

class MedicineWidget extends StatelessWidget {
  const MedicineWidget({super.key});

  String get textName =>
      'medicament name medicament name'.split(' ').take(2).join(' ');

  String get textCompanyName =>
      'Company Name Company Name'.split(' ').take(2).join(' ');

  @override
  Widget build(BuildContext context) {
    final tag = UniqueKey();
    return InkWell(
      onTap: () {
        // todo
        pushNamed(AppRoute.medicineDetails, context,
            arguments: ScreenArguments({
              // AppKeys.itemModel: itemModel,
              AppKeys.tag: tag,
            }));
      },
      child: Container(
        width: AppSize.widthCard,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: AppColor.cardColor,
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
                  imageUrl:
                      'https://upload.wikimedia.org/wikipedia/commons/f/f9/Phoenicopterus_ruber_in_S%C3%A3o_Paulo_Zoo.jpg',
                  errorWidget: ErrorWidgetShow.picture,
                ),
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(textName, style: AppTextTheme.f15w400black),
              ),
            ),
            const Gap(3),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(textCompanyName, style: AppTextTheme.f15w400black),
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}

class MedicineListWidget extends StatelessWidget {
  const MedicineListWidget({
    super.key,
    // required this.medicines,
    required this.onRefresh,
  });

  // final List<MedicineModel> medicines;
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
                15,
                (index) => const MedicineWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
