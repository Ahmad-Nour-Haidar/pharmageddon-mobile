import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static const transparent = Color(0x00000000);
  static const gray = Colors.grey;
  static const gray1 = Color(0xFF676464);
  static const gray2 = Color(0xFFD9D9D9);
  static const gray3 = Color(0xFFc7c7c7);
  static const gray4 = Color(0xFFE7E7E7);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const background = Color(0xFFA2DBFA);
  static const blue = Color(0xFF0000FF);
  static const blue2 = Color(0xFF00bfff);
  static const primaryColor = Color(0xFF528AC8);
  static const secondColor = Color(0xFF00538B);
  static const green2 = Color(0xFF00C5A2);
  static const cardColor = Color(0xFFCDE5FF);
  static const snackbarColor = Color(0xFFffab00);
  static const Color red = Color(0xFFFF0000);
  static const Color red2 = Color(0xFFF44336);
  static const Color green = Color(0xFF4EF037);
  static const Color green3 = Colors.green;
  static const Color textColor = Color(0xff7A0F88);

  static const primary = contentColorCyan;
  static const menuBackground = Color(0xFF090912);
  static const itemsBackground = Color(0xFF1B2339);
  static const pageBackground = Color(0xFF282E45);
  static const mainTextColor1 = Colors.white;
  static const mainTextColor2 = Colors.white70;
  static const mainTextColor3 = Colors.white38;
  static const mainGridLineColor = Colors.white10;
  static const borderColor = Colors.white54;
  static const gridLinesColor = Color(0x11FFFFFF);

  static const contentColorBlack = Colors.black;
  static const contentColorWhite = Colors.white;
  static const contentColorBlue = Color(0xFF2196F3);
  static const contentColorYellow = Color(0xFFFFC300);
  static const contentColorOrange = Color(0xFFFF683B);
  static const contentColorGreen = Color(0xFF3BFF49);
  static const contentColorPurple = Color(0xFF6E1BFF);
  static const contentColorPink = Color(0xFFFF3AF2);
  static const contentColorRed = Color(0xFFE80054);
  static const contentColorCyan = Color(0xFF50E4FF);

  static final _colors = [
    const Color(0xFF2196F3),
    const Color(0xFFFFC300),
    const Color(0xFFFF683B),
    const Color(0xFF3BFF49),
    const Color(0xFF6E1BFF),
    const Color(0xFFFF3AF2),
    const Color(0xFFE80054),
    const Color(0xFFFF6633),
    const Color(0xFFFFB399),
    const Color(0xFFFF33FF),
    const Color(0xFFFFFF99),
    const Color(0xFF00B3E6),
    const Color(0xFFE6B333),
    const Color(0xFF99FF99),
    const Color(0xFFB34D4D),
    const Color(0xFF80B300),
    const Color(0xFFE6B3B3),
    const Color(0xFF6680B3),
    const Color(0xFF66991A),
    const Color(0xFFFF99E6),
    const Color(0xFFCCFF1A),
    const Color(0xFFFF1A66),
    const Color(0xFFE6331A),
    const Color(0xFF33FFCC),
    const Color(0xFF66994D),
    const Color(0xFFB366CC),
    const Color(0xFF4D8000),
    const Color(0xFFB33300),
    const Color(0xFFCC80CC),
    const Color(0xFF66664D),
    const Color(0xFF991AFF),
    const Color(0xFFE666FF),
    const Color(0xFF4DB3FF),
    const Color(0xFF1AB399),
    const Color(0xFFE666B3),
    const Color(0xFF33991A),
    const Color(0xFFCC9999),
    const Color(0xFFB3B31A),
    const Color(0xFF00E680),
    const Color(0xFF4D8066),
    const Color(0xFFE6FF80),
    const Color(0xFF1AFF33),
    const Color(0xFF999933),
    const Color(0xFFFF3380),
    const Color(0xFFCCCC00),
    const Color(0xFF66E64D),
    const Color(0xFF4D80CC),
    const Color(0xFF9900B3),
    const Color(0xFFE64D66),
    const Color(0xFF4DB380),
    const Color(0xFFFF4D4D),
    const Color(0xFF99E6E6),
    const Color(0xFF6666FF)
  ];

  static Color get(int index) => _colors[(index % _colors.length)];
}
