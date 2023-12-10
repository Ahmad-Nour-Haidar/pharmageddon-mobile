import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/constant/app_lottie.dart';

class AppWidget {
  final noData = Center(
    child: Lottie.asset(AppLottie.noData,
        width: 180, height: 210, fit: BoxFit.fill),
  );

  final noDataAfterSearch = Center(
    child: Lottie.asset(AppLottie.noDataAfterSearch,
        width: 180, height: 210, fit: BoxFit.fill),
  );

  final addFav = Center(
    child: Lottie.asset(AppLottie.addFav,
        width: 180, height: 210, fit: BoxFit.fill),
  );
}
