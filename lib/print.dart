import 'package:flutter/material.dart';

class printme {
  printme._();

  static void black(text) => debugPrint('\x1B[30m$text\x1B[0m');

  static void red(text) => debugPrint('\x1B[31m$text\x1B[0m');

  static void green(text) => debugPrint('\x1B[32m$text\x1B[0m');

  static void yellow(text) => debugPrint('\x1B[33m$text\x1B[0m');

  static void yellowAccent(text) {
    const customColorCode = '\x1B[38;2;255;255;0m'; // Yellow (FFFF00FF)
    const resetCode = '\x1B[0m';
    debugPrint('$customColorCode$text$resetCode');
  }

  static void blue(text) => debugPrint('\x1B[34m$text\x1B[0m');

  static void magenta(text) => debugPrint('\x1B[35m$text\x1B[0m');

  // light blue
  static void cyan(text) => debugPrint('\x1B[36m$text\x1B[0m');

  static void white(text) => debugPrint('\x1B[37m$text\x1B[0m');

  static void gray(text) => debugPrint('\x1B[38m$text\x1B[0m');

  static void printColoredText({
    required text,
    required Color color,
  }) {
    final colorCode = color.toString().split('(0x')[1].split(')')[0];
    // debugPrint(colorCode);
    final formattedText =
        '\x1B[38;2;${Color(int.parse(colorCode, radix: 16)).red};'
        '${Color(int.parse(colorCode, radix: 16)).green};'
        '${Color(int.parse(colorCode, radix: 16)).blue}m$text\x1B[0m';
    debugPrint(formattedText);
  }

  static void printFullText(text) {
    text = text.toString();
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => yellowAccent(match.group(0)));
  }
}
