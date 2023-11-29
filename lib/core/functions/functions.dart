import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pharmageddon_mobile/core/constant/app_keys_request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/user_model.dart';
import '../constant/app_constant.dart';
import '../constant/app_keys_storage.dart';
import '../constant/app_local_data.dart';
import '../services/dependency_injection.dart';
import 'package:pharmageddon_mobile/print.dart';
bool isEnglish() => AppConstant.currentLocal == AppConstant.localEn;

String getCodeLang() =>
    AppConstant.currentLocal == AppConstant.localEn ? 'en' : 'ar';

String formatDateJiffy(DateTime date) {
  return Jiffy.parseFromDateTime(date)
      .format(pattern: 'EEEE, MMMM, d - MM - yyyy');
}

String formatTimeJiffy(DateTime date) {
  return Jiffy.parseFromDateTime(date).format(pattern: 'h:mm a');
}

TextDirection getTextDirection(String value) {
  if (value.contains(RegExp(r"[\u0600-\u06FF]"))) {
    return TextDirection.rtl;
  } else {
    return TextDirection.ltr;
  }
}

TextDirection getTextDirectionOnLang() {
  if (isEnglish()) {
    return TextDirection.ltr;
  } else {
    return TextDirection.rtl;
  }
}

Future<void> storeUser(Map<String, dynamic> response) async {
  final user = User.fromJson(response[AppRKeys.data][AppRKeys.user]);
  final sh = AppInjection.getIt<SharedPreferences>();
  final jsonString = jsonEncode(user.toJson());
  await sh.setString(AppKeysStorage.user, jsonString);
  AppLocalData.user = user;
  // printme.yellowAccent(AppLocalData.user);
}

void initialUser() {
  final sh = AppInjection.getIt<SharedPreferences>();
  var jsonString = sh.getString(AppKeysStorage.user);
  if (jsonString == null) {
    return;
  }
  final Map<String, dynamic> m = jsonDecode(jsonString);
  var user = User.fromJson(m);
  AppLocalData.user = user;
  // printme.green(user.authorization);
  return;
}
