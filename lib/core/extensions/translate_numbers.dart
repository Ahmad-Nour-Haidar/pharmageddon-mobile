import 'package:pharmageddon_mobile/controllers/local_controller.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';

extension TranslateNumbers on String {
  String get trn {
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
