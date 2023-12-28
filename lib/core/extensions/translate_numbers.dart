import '../constant/app_constant.dart';

extension TranslateNumbers on String {
  String get trn {
    if (AppConstant.isEnglish) return this;
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
