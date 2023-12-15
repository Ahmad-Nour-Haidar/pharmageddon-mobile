import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_padding.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_strings.dart';
import '../../../core/functions/functions.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../model/medication_model.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({
    super.key,
    required this.data,
  });

  final List<MedicationModel> data;

  Widget _cell({
    required String s,
    required Color color,
    TextStyle ts = AppTextStyle.f15w400black,
    required BorderRadius borderRadius,
  }) {
    return Container(
      padding: AppPadding.padding7,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: Border.all(
          color: AppColor.secondColor,
          width: 2,
        ),
      ),
      child: Text(s, style: ts),
    );
  }

  Widget _customTableRow({
    required String s1,
    required String s2,
    required Color color,
    TextStyle ts1 = AppTextStyle.f15w400black,
    TextStyle ts2 = AppTextStyle.f15w400black,
    BorderRadius br1 = BorderRadius.zero,
    BorderRadius br2 = BorderRadius.zero,
  }) {
    return Row(
      children: [
        Expanded(
          child: _cell(
            s: s1,
            ts: ts1,
            borderRadius: br1,
            color: color,
          ),
        ),
        Expanded(
          child: _cell(
            s: s2,
            ts: ts2,
            borderRadius: br2,
            color: color,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.height * .25,
      child: Column(
        children: [
          _customTableRow(
            color: AppColor.green2,
            s1: AppText.name.tr,
            s2: AppText.availableQuantity.tr,
            br1: BorderRadius.only(
              topLeft: Radius.circular(isEnglish() ? 10 : 0),
              topRight: Radius.circular(isEnglish() ? 0 : 10),
            ),
            br2: BorderRadius.only(
              topLeft: Radius.circular(isEnglish() ? 0 : 10),
              topRight: Radius.circular(isEnglish() ? 10 : 0),
            ),
            ts1: AppTextStyle.f15w600black,
            ts2: AppTextStyle.f15w600black,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(
                    data.length - 1,
                    (index) => _customTableRow(
                      color: AppColor.cardColor,
                      s1: getMedicationCommercialName(data[index]),
                      s2: data[index].availableQuantity.toString(),
                    ),
                  ),
                  _customTableRow(
                    color: AppColor.cardColor,
                    s1: getMedicationCommercialName(data[data.length - 1]),
                    s2: data[data.length - 1].availableQuantity.toString(),
                    br1: BorderRadius.only(
                      bottomLeft: Radius.circular(isEnglish() ? 10 : 0),
                      bottomRight: Radius.circular(isEnglish() ? 0 : 10),
                    ),
                    br2: BorderRadius.only(
                      bottomLeft: Radius.circular(isEnglish() ? 0 : 10),
                      bottomRight: Radius.circular(isEnglish() ? 10 : 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
