import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constant/app_constant.dart';
import '../core/constant/app_keys_storage.dart';
import '../core/services/dependency_injection.dart';

class LocaleController extends GetxController {
  late Locale locale;
  final sh = AppInjection.getIt<SharedPreferences>();

  LocaleController() {
    onInit();
  }

  Future<void> changeLang(String codeLang) async {
    final locale = Locale(codeLang);
    sh.setString(AppKeysStorage.langKey, codeLang);
    await Jiffy.setLocale(codeLang);
    Get.updateLocale(locale);
  }

  @override
  void onInit() async {
    String? s = sh.getString(AppKeysStorage.langKey);
    if (s == AppConstant.ar) {
      locale = const Locale(AppConstant.ar);
    } else if (s == AppConstant.en) {
      locale = const Locale(AppConstant.en);
    } else {
      locale = Locale(Get.deviceLocale!.languageCode);
    }
    await Jiffy.setLocale(locale.languageCode);
    super.onInit();
  }
}
