import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_size.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ManufacturerWidget extends StatelessWidget {
  const ManufacturerWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: AppPadding.padding15,
        height: 100,
        width: AppSize.widthManufacturer,
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: AutoSizeText(
          text,
          style: AppTextTheme.f18w500black,
          maxLines: 3,
        ),
      ),
    );
  }
}

class ManufacturersListWidget extends StatelessWidget {
  const ManufacturersListWidget({
    super.key,
    // required this.medicines,
    required this.onRefresh,
  });

  // final List<ManufacturerModel> medicines;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          children: [
            Wrap(
              spacing: 50,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: List.generate(
                AppConstant.pharmaceuticalCompanies.length,
                (index) => ManufacturerWidget(
                  text: AppConstant.pharmaceuticalCompanies[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
