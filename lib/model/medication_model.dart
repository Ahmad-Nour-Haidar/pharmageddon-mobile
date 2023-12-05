import 'effect_category_model.dart';
import 'manufacturer_model.dart';

class MedicationModel {
  int? id;
  String? englishScientificName;
  String? arabicScientificName;
  String? englishCommercialName;
  String? arabicCommercialName;
  int? availableQuantity;
  double? price;
  double? discount;
  double? priceAfterDiscount;
  bool? isFavourite;
  String? description;
  String? imageName;
  String? expirationDate;
  String? createdAt;
  ManufacturerModel? manufacturer;
  EffectCategoryModel? effectCategory;

  MedicationModel(
      {this.id,
      this.englishScientificName,
      this.arabicScientificName,
      this.englishCommercialName,
      this.arabicCommercialName,
      this.availableQuantity,
      this.price,
      this.discount,
      this.priceAfterDiscount,
      this.isFavourite,
      this.description,
      this.imageName,
      this.expirationDate,
      this.createdAt,
      this.manufacturer,
      this.effectCategory});

  MedicationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    englishScientificName = json['english_scientific_name'];
    arabicScientificName = json['arabic_scientific_name'];
    englishCommercialName = json['english_commercial_name'];
    arabicCommercialName = json['arabic_commercial_name'];
    availableQuantity = json['available_quantity'];
    price = double.parse(json['price'].toString());
    discount = double.parse(json['discount'].toString());
    priceAfterDiscount = double.parse(json['price_after_discount'].toString());
    isFavourite = json['is_favourite'];
    description = json['description'];
    imageName = json['image_name'];
    expirationDate = json['expiration_date'];
    createdAt = json['created_at'];
    manufacturer = json['manufacturer'] != null
        ? ManufacturerModel.fromJson(json['manufacturer'])
        : null;
    effectCategory = json['effect_category'] != null
        ? EffectCategoryModel.fromJson(json['effect_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['english_scientific_name'] = englishScientificName;
    data['arabic_scientific_name'] = arabicScientificName;
    data['english_commercial_name'] = englishCommercialName;
    data['arabic_commercial_name'] = arabicCommercialName;
    data['available_quantity'] = availableQuantity;
    data['price'] = price;
    data['discount'] = discount;
    data['price_after_discount'] = priceAfterDiscount;
    data['is_favourite'] = isFavourite;
    data['description'] = description;
    data['image_name'] = imageName;
    data['expiration_date'] = expirationDate;
    data['created_at'] = createdAt;
    if (manufacturer != null) {
      data['manufacturer'] = manufacturer!.toJson();
    }
    if (effectCategory != null) {
      data['effect_category'] = effectCategory!.toJson();
    }
    return data;
  }
}
