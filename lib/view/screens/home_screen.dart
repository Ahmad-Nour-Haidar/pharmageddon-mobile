import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
import 'package:pharmageddon_mobile/core/constant/app_image.dart';
import 'package:pharmageddon_mobile/core/constant/app_size.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';
import '../../core/constant/app_svg.dart';
import '../../core/functions/navigator.dart';
import '../../model/screen_arguments.dart';
import '../../routes.dart';
import '../widgets/Custom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBar(
        onChange: (index) {},
        list: AppConstant.homeList,
      ),
      appBar: const CustomAppBar().build(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.screenPadding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.home.tr,
                  style: AppTextTheme.f20w600black,
                ),
                InkWell(
                  radius: 20,
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(AppSvg.search),
                  ),
                )
              ],
            ),
            MedicineListWidget(onRefresh: () async {}),
          ],
        ),
      ),
    );
  }
}

class MedicineWidget extends StatelessWidget {
  const MedicineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tag = UniqueKey();
    return InkWell(
      onTap: () {
        // todo
        pushNamed(AppRoute.home, context,
            arguments: ScreenArguments({
              // AppKeys.itemModel: itemModel,
              // AppKeys.tag: tag,
            }));
      },
      child: Container(
        // height: AppSize.heightCard,
        width: AppSize.widthCard,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: AppColor.cardColor,
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
                child: CachedNetworkImage(
                  httpHeaders: const {
                    "Connection": "Keep-Alive",
                    "Keep-Alive": "timeout=5",
                  },
                  width: AppSize.widthCard,
                  height: AppSize.widthCard,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  fit: BoxFit.fill,
                  imageUrl: '',
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      AppImage.backgroundMobile,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'medicament name medicament name',
                    style: AppTextTheme.f15w400black,
                  )),
            ),
            const Gap(3),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Company Name Company Name',
                  style: AppTextTheme.f15w400black,
                ),
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
