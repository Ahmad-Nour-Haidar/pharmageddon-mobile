import 'package:flutter/widgets.dart';

import 'app_svg.dart';

class AppConstant {
  AppConstant._();

  static const ar = 'ar';
  static const en = 'en';
  static const pharmacist = 'pharmacist';

  static const localEn = Locale(en);
  // static const localAr = Locale(ar);

  static const homeList = [
    AppSvg.text,
    AppSvg.all,
    AppSvg.chemistry,
  ];

  static const pharmaceuticalCompanies = [
    'Pfizer',
    'Johnson & Johnson',
    'Roche',
    'Novartis',
    'Merck & Co.',
    'Sanofi',
    'GlaxoSmithKline',
    'AstraZeneca',
    'Eli Lilly and Company',
    'AbbVie',
  ];
}
