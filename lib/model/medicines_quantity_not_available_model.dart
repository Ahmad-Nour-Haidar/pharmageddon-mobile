class MedicinesQuantityNotAvailableModel {
  int? medicineId;
  int? newQuantity;
  String? englishScientificName;
  String? arabicScientificName;
  String? englishCommercialName;
  String? arabicCommercialName;

  MedicinesQuantityNotAvailableModel(
      {this.medicineId,
      this.newQuantity,
      this.englishScientificName,
      this.arabicScientificName,
      this.englishCommercialName,
      this.arabicCommercialName});

  MedicinesQuantityNotAvailableModel.fromJson(Map<String, dynamic> json) {
    medicineId = json['medicine_id'];
    newQuantity = json['new_quantity'];
    englishScientificName = json['english_scientific_name'];
    arabicScientificName = json['arabic_scientific_name'];
    englishCommercialName = json['english_commercial_name'];
    arabicCommercialName = json['arabic_commercial_name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['medicine_id'] = medicineId;
    data['new_quantity'] = newQuantity;
    data['english_scientific_name'] = englishScientificName;
    data['arabic_scientific_name'] = arabicScientificName;
    data['english_commercial_name'] = englishCommercialName;
    data['arabic_commercial_name'] = arabicCommercialName;
    return data;
  }
}
