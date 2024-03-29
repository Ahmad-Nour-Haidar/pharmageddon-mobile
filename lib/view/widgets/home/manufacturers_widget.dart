import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_keys.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_size.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/core/functions/navigator.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
import 'package:pharmageddon_mobile/routes.dart';

import '../../../core/services/dependency_injection.dart';
import '../../../model/manufacturer_model.dart';
import '../app_widget.dart';

class ManufacturerWidget extends StatelessWidget {
  const ManufacturerWidget({
    super.key,
    required this.model,
  });

  final ManufacturerModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pushNamed(AppRoute.factoryMedicinesScreen, context,
          arguments: {AppKeys.manufacturerModel: model}),
      child: Container(
        padding: AppPadding.padding15,
        height: 100,
        width: AppSize.widthManufacturer,
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: AutoSizeText(
            getManufacturerName(model),
            textAlign: TextAlign.center,
            style: AppTextStyle.f18w500black,
            maxLines: 3,
          ),
        ),
      ),
    );
  }
}

class ManufacturersListWidget extends StatelessWidget {
  const ManufacturersListWidget({
    super.key,
    required this.data,
    required this.onRefresh,
  });

  final List<ManufacturerModel> data;
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
                  Center(
                    child: Wrap(
                      spacing: 30,
                      runSpacing: 20,
                      children: List.generate(
                        data.length,
                        (index) => ManufacturerWidget(
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
