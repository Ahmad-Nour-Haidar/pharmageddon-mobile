
class ManufacturerModel {
  int? id;
  String? arabicName;
  String? englishName;

  ManufacturerModel({this.id, this.arabicName, this.englishName});

  ManufacturerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arabicName = json['arabic_name'];
    englishName = json['english_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['arabic_name'] = arabicName;
    data['english_name'] = englishName;
    return data;
  }
}
