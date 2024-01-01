import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/constant/app_color.dart';
import '../../core/functions/functions.dart';
import '../../core/resources/app_text_theme.dart';
import '../../model/order_model.dart';

class CustomPieChart extends StatefulWidget {
  const CustomPieChart({super.key, required this.data});

  final List<OrderModel> data;

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  int touchedIndex = -1;
  String selectedSection = ' ';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(20),
        Text(
          selectedSection,
          style: AppTextStyle.f20w600black,
        ),
        const Gap(20),
        Expanded(
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      selectedSection = ' ';
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                    if (touchedIndex >= 0 &&
                        touchedIndex < widget.data.length) {
                      selectedSection =
                          formatYYYYMd(widget.data[touchedIndex].createdAt);
                    }
                  });
                },
              ),
              sectionsSpace: 0,
              sections: List.generate(widget.data.length, (index) {
                final isTouched = index == touchedIndex;
                final fontSize = isTouched ? 22.0 : 14.0;
                final radius = isTouched ? 130.0 : 120.0;
                const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
                return PieChartSectionData(
                  value: widget.data[index].totalPrice,
                  title: widget.data[index].totalPrice.toString(),
                  showTitle: true,
                  radius: radius,
                  color: AppColor.get(index),
                  titleStyle: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                    shadows: shadows,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
