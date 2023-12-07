import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/print.dart';

import '../../core/resources/app_text_theme.dart';

class RowText extends StatelessWidget {
  const RowText({
    super.key,
    required this.s1,
    required this.s2,
    this.ts1 = AppTextTheme.f16w600black,
    this.ts2 = AppTextTheme.f16w400black,
    this.textDirection,
    this.alignment,
  });

  final String s1, s2;
  final TextStyle ts1, ts2;
  final TextDirection? textDirection;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(s1, style: ts1),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            s2,
            style: ts2,
            maxLines: 10,
          ),
        ),
        // Expanded(
        //   child: Align(
        //     alignment: alignment ??
        //         (isEnglish() ? Alignment.centerLeft : Alignment.centerRight),
        //     child: Directionality(
        //       textDirection: TextDirection.rtl,
        //       child: AutoSizeText(
        //         s2,
        //         style: ts2,
        //         maxLines: 10,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
