

class EffectCategoryModel {
  int? id;
  String? arabicName;
  String? englishName;
  String? imageName;

  EffectCategoryModel({this.id, this.arabicName, this.englishName, this.imageName});

  EffectCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arabicName = json['arabic_name'];
    englishName = json['english_name'];
    imageName = json['image_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['arabic_name'] = arabicName;
    data['english_name'] = englishName;
    data['image_name'] = imageName;
    return data;
  }
}
