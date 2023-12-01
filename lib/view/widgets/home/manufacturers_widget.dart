import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_size.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
import 'package:pharmageddon_mobile/print.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ManufacturerWidget extends StatelessWidget {
  const ManufacturerWidget({super.key});

  static final s = (AppSize.width * .35).toInt() * 1.0;
  static const ss = 'Ahmad Nour';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.padding20,
      height: 100,
      width: s,
      decoration: BoxDecoration(
        color: AppColor.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const AutoSizeText(
        ss,
        style: AppTextTheme.f26w600black,
        maxLines: 3,
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
              spacing: 20,
              runSpacing: 10,
              children: List.generate(
                AppConstant.pharmaceuticalCompanies.length,
                (index) => const ManufacturerWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
