import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/print.dart';
import 'core/constant/app_color.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    AppColor.contentColorCyan,
    AppColor.contentColorBlue,
  ];

  bool showAvg = false;

  final _s = ScrollController(initialScrollOffset: 500);

  @override
  void initState() {
    // _s.addListener(() { });
    // _s.jumpTo(100);
    super.initState();
  }

  final List<FlSpot> spots = List.generate(
      10,
      (index) =>
          FlSpot((index + 2).toDouble(), (index * (Random().nextInt(5) + 1))));

  @override
  Widget build(BuildContext context) {
    // return TwoDimensionalChildBuilderDelegate(builder: builder);
    // return TwoDimensionalScrollable(
    //   viewportBuilder: (context, verticalPosition, horizontalPosition) {
    //     printme.cyan('12');
    //     return Container(
    //       color: AppColor.primaryColor,
    //       child: const SizedBox(
    //           width: 1000,
    //           height: 1000,
    //           child: Text(
    //               'nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()\nvertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()vertical()7878787878787878')),
    //     );
    //   },
    //   horizontalDetails: ScrollableDetails.horizontal(
    //     physics: const BouncingScrollPhysics(),
    //   ),
    //   verticalDetails: ScrollableDetails.vertical(
    //     physics: BouncingScrollPhysics(),
    //   ),
    // );

    return SingleChildScrollView(
      child: SizedBox(
        height: 1000,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            width: spots.length * 100,
            child: LineChart(
              showAvg ? avgData() : mainData(),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      // fontWeight: FontWeight.r,
      fontSize: 15,
      letterSpacing: 1,
    );
    return Text((value.toInt()).toString(),
        style: style, textAlign: TextAlign.left);
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      // fontWeight: FontWeight.r,
      fontSize: 15,
      letterSpacing: 1,
    );
    return Text((value.toInt() % 5).toString(),
        style: style, textAlign: TextAlign.left);
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    printme.magenta(spots);
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColor.red,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColor.red,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: AppColor.red),
      ),
      minX: 0,
      maxX: (spots.length + 10) * 1.0,
      minY: 0,
      maxY: 50,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          // isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
