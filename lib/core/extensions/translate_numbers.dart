import 'package:pharmageddon_mobile/controllers/local_controller.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';

extension TranslateNumbers on String {
  trNumber() {
    if (AppInjection.getIt<LocaleController>().locale.languageCode ==
        AppConstant.en) return this;
    const keys = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };
    final text = StringBuffer();
    final length = this.length;
    for (int i = 0; i < length; i++) {
      final s = keys[this[i]] ?? this[i];
      text.write(s);
    }
    return text.toString();
  }
}

extension NumberConverter on num {
  static const Map<String, String> arabicDigits = <String, String>{
    '0': '\u0660',
    '1': '\u0661',
    '2': '\u0662',
    '3': '\u0663',
    '4': '\u0664',
    '5': '\u0665',
    '6': '\u0666',
    '7': '\u0667',
    '8': '\u0668',
    '9': '\u0669',
  };

  String toArabicDigits() {
    final String number = toString();
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < number.length; i++) {
      sb.write(arabicDigits[number[i]] ?? number[i]);
    }
    return sb.toString();
  }
}
