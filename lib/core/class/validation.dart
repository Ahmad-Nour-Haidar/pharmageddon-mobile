import 'package:get/get.dart';

import '../constant/app_text.dart';
import '../functions/functions.dart';

class ValidateInput {
  ValidateInput._();

  static const _regExpEmail =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const _regExpPhone = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
  static const _regExpPhone2 = r'^09\d{8}$';
  static const _regExpUsername = r'^[a-zA-Z0-9][a-zA-Z0-9_. ]+[a-zA-Z0-9]$';
  static const _regExpPassword =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';

  static String _getMessageLength(int mn, int mx) =>
      '${AppText.lengthMustBeBetween.tr} $mn - $mx';

  static String _getMessageNotValid(String field) =>
      '$field ${AppText.notValid.tr}';

  static String? isEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (!_hasMatch(value, _regExpEmail)) {
      return _getMessageNotValid(AppText.email.tr);
    }
    if (!value.endsWith('@gmail.com')) {
      return isEnglish()
          ? '${AppText.emailMustBeEndWith.tr}: @gmail.com'
          : '@gmail.com :${AppText.emailMustBeEndWith.tr}';
    }
    if (value.length < 13 || value.length > 50) {
      return _getMessageLength(13, 50);
    }
    return null;
  }

  static String? isPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (value.length < 8 || value.length > 50) {
      return _getMessageLength(8, 50);
    }
    if (!_hasMatch(value, _regExpPassword)) {
      return AppText.passwordMustBeAtLeast8.tr;
    }
    return null;
  }

  static String? isPhone(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    // if (value.length < 9 || value.length > 16) {
    //   return _getMessageLength(9, 16);
    // }
    if (!_hasMatch(value, _regExpPhone2)) {
      return AppText.thePhoneNumberMustStartWith.tr;
      // return _getMessageNotValid(AppStrings.phone.tr);
    }
    return null;
  }

  static String? isUsername(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (value.length < 3 || value.length > 50) {
      return _getMessageLength(3, 50);
    }
    if (!_hasMatch(value, _regExpUsername)) {
      return _getMessageNotValid(AppText.userName.tr);
    }
    return null;
  }

  static String? isAddress(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (value.length < 10 || value.length > 200) {
      return _getMessageLength(10, 200);
    }
    return null;
  }

  static bool _hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }
}
