import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pharmageddon_mobile/data/local/app_hive.dart';

import '../core/constant/app_constant.dart';
import '../core/constant/app_storage_keys.dart';
import '../core/services/dependency_injection.dart';

class LocaleController extends GetxController {
  LocaleController._();

  static Future<LocaleController> getInstance() async {
    final LocaleController localeController = LocaleController._();
    await localeController.initial();
    return localeController;
  }

  late Locale _locale;
  final _appHive = AppInjection.getIt<AppHive>();

  Locale get locale => _locale;

  Future<void> changeLang(String codeLang) async {
    if (_locale.languageCode == codeLang) return;
    _locale = Locale(codeLang);
    await _appHive.store(AppSKeys.langKey, codeLang);
    await Jiffy.setLocale(codeLang);
    AppConstant.isEnglish = locale.languageCode == AppConstant.en;
    Get.updateLocale(_locale);
  }

  Future<void> initial() async {
    String s = _appHive.get(AppSKeys.langKey) ?? '';
    if (s == AppConstant.ar) {
      _locale = const Locale(AppConstant.ar);
    } else if (s == AppConstant.en) {
      _locale = const Locale(AppConstant.en);
    } else {
      _locale = Locale(Get.deviceLocale!.languageCode);
    }
    AppConstant.isEnglish = locale.languageCode == AppConstant.en;
    await Jiffy.setLocale(locale.languageCode);
    super.onInit();
  }
}
