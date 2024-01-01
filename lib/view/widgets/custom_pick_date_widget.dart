import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_constant.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_text.dart';
import '../../core/constant/app_svg.dart';
import '../../core/functions/functions.dart';
import '../../core/resources/app_text_theme.dart';

class CustomPickDateWidget extends StatelessWidget {
  const CustomPickDateWidget({
    super.key,
    required this.onChange,
    required this.dateTimeRange,
  });

  final void Function(DateTimeRange dateTimeRange) onChange;
  final DateTimeRange dateTimeRange;

  String get textStart {
    var s = AppText.start.tr;
    if (dateTimeRange.duration.inDays > 0) {
      s = formatYYYYMd(dateTimeRange.start.toString());
    }
    return s;
  }

  String get textEnd {
    var s = AppText.end.tr;
    if (dateTimeRange.duration.inDays > 0) {
      s = formatYYYYMd(dateTimeRange.end.toString());
    }
    return s;
  }

  void show(BuildContext context) async {
    final timeRange = await showDateRangePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDateRange: DateTimeRange(
        start: DateTime.now().subtract(const Duration(days: 7)),
        end: DateTime.now(),
      ),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.secondColor,
              onPrimary: AppColor.white,
              onSurface: AppColor.secondColor,
              background: AppColor.secondColor,
              onSecondary: AppColor.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (timeRange != null) {
      onChange(timeRange);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => show(context),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: AppPadding.padding10,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                textStart,
                style: AppTextStyle.f18w500black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SvgImage(
              path: AppConstant.isEnglish
                  ? AppSvg.arrowFillRight
                  : AppSvg.arrowFillLeft,
              color: AppColor.green2,
              size: 32,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: AppPadding.padding10,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                textEnd,
                style: AppTextStyle.f18w500black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
