import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pharmageddon_mobile/core/constant/app_request_keys.dart';
import 'package:pharmageddon_mobile/data/local/app_hive.dart';

import '../../controllers/local_controller.dart';
import '../../model/effect_category_model.dart';
import '../../model/manufacturer_model.dart';
import '../../model/medication_model.dart';
import '../../model/user_model.dart';
import '../constant/app_constant.dart';
import '../constant/app_link.dart';
import '../constant/app_local_data.dart';
import '../constant/app_storage_keys.dart';
import '../services/dependency_injection.dart';

bool isEnglish() =>
    AppInjection.getIt<LocaleController>().locale == AppConstant.localEn;

String getCodeLang() =>
    AppInjection.getIt<LocaleController>().locale.languageCode;

Future<void> storeUser(Map<String, dynamic> response) async {
  final user = User.fromJson(response[AppRKeys.data][AppRKeys.user]);
  final appHive = AppInjection.getIt<AppHive>();
  appHive.store(AppSKeys.userKey, user.toJson());
  AppLocalData.user = user;
  // printme.yellowAccent(AppLocalData.user);
}

void initialUser() {
  final appHive = AppInjection.getIt<AppHive>();
  final Map? jsonString = appHive.get(AppSKeys.userKey);
  if (jsonString == null) {
    return;
  }
  final Map<String, dynamic> jsonUser = {};
  jsonString.forEach((key, value) {
    jsonUser[key.toString()] = value;
  });
  var user = User.fromJson(jsonUser);
  AppLocalData.user = user;
  // printme.green(user.authorization);
  return;
}

String formatYYYYMd(String? s) {
  final date = DateTime.tryParse(s ?? '');
  if (date == null) return ' --- ';
  final pattern = isEnglish() ? 'yyyy - M - d' : 'd - M - yyyy';
  return Jiffy.parseFromDateTime(date).format(pattern: pattern);
}

String formatYYYYMdEEEE(String? s) {
  final date = DateTime.tryParse(s ?? '');
  if (date == null) return ' --- ';
  final pattern = isEnglish() ? 'EEEE , yyyy - M - d' : 'EEEE , d - M - yyyy';
  return Jiffy.parseFromDateTime(date).format(pattern: pattern);
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

int getRandom() => Random().nextInt(5) + 5;

String getMedicationScientificName(MedicationModel? model,
    {bool split = true}) {
  var s = '';
  if (model == null) return s;
  if (split) {
    if (isEnglish()) {
      s = model.englishScientificName.toString().split(' ').take(2).join(' ');
    } else {
      s = model.arabicScientificName.toString().split(' ').take(2).join(' ');
    }
    return s;
  }
  if (isEnglish()) {
    s = model.englishScientificName.toString();
  } else {
    s = model.arabicScientificName.toString();
  }
  return s;
}

String getMedicationCommercialName(MedicationModel? model,
    {bool split = true}) {
  var s = '';
  if (model == null) return s;
  if (split) {
    if (isEnglish()) {
      s = model.englishCommercialName.toString().split(' ').take(2).join(' ');
    } else {
      s = model.arabicCommercialName.toString().split(' ').take(2).join(' ');
    }
    return s;
  }
  if (isEnglish()) {
    s = model.englishCommercialName.toString();
  } else {
    s = model.arabicCommercialName.toString();
  }
  return s;
}

String getUrlImageMedication(MedicationModel? model) {
  final s = '${AppLink.medicineImage}/${model?.imageName}';
  return s;
}

String getManufacturerName(ManufacturerModel? model, {bool split = true}) {
  var s = '';
  if (model == null) return s;
  if (split) {
    if (isEnglish()) {
      s = model.englishName.toString().split(' ').take(2).join(' ');
    } else {
      s = model.arabicName.toString().split(' ').take(2).join(' ');
    }
    return s;
  }
  if (isEnglish()) {
    s = model.englishName.toString();
  } else {
    s = model.arabicName.toString();
  }
  return s;
}

String getEffectCategoryModelName(EffectCategoryModel? model,
    {bool split = true}) {
  var s = '';
  if (model == null) return s;
  if (split) {
    if (isEnglish()) {
      s = model.englishName.toString().split(' ').take(2).join(' ');
    } else {
      s = model.arabicName.toString().split(' ').take(2).join(' ');
    }
    return s;
  }
  if (isEnglish()) {
    s = model.englishName.toString();
  } else {
    s = model.arabicName.toString();
  }
  return s;
}

String getMedicationModelDescription(MedicationModel? model) {
  var s = '';
  if (model == null) return s;
  if (isEnglish()) {
    s = model.englishDescription.toString();
  } else {
    s = model.arabicDescription.toString();
  }
  return s;
}
