import 'package:get/get.dart';
import '../constant/app_request_keys.dart';

String checkErrorMessages(List<dynamic> errors) {
  String result = '';
  for (String error in errors) {
    error = error.toString();
    if (error.toLowerCase().contains(AppRKeys.email)) {
      result.isNotEmpty ? result += ', ' : 1;
      result += AppRKeys.email.tr;
    } else if (error.toLowerCase().contains(AppRKeys.phone)) {
      result.isNotEmpty ? result += ', ' : 1;
      result += AppRKeys.phone.tr;
    } else if (error.toLowerCase().contains(AppRKeys.username)) {
      result.isNotEmpty ? result += ', ' : 1;
      result += AppRKeys.username.tr;
    }
  }
  return result;
}
