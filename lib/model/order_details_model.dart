class OrderDetailsModel {
  int? medicineId;
  String? medicineEnglishCommercialName;
  String? medicineArabicCommercialName;
  int? totalQuantity;
  int? priceWhenOrdered;
  int? totalPrice;
  int? hasDiscount;

  OrderDetailsModel(
      {this.medicineId,
      this.medicineEnglishCommercialName,
      this.medicineArabicCommercialName,
      this.totalQuantity,
      this.priceWhenOrdered,
      this.totalPrice,
      this.hasDiscount});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    medicineId = json['medicine_id'];
    medicineEnglishCommercialName = json['medicine_english_commercial_name'];
    medicineArabicCommercialName = json['medicine_arabic_commercial_name'];
    totalQuantity = json['total_quantity'];
    priceWhenOrdered = json['price_when_ordered'];
    totalPrice = json['total_price'];
    hasDiscount = json['has_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medicine_id'] = medicineId;
    data['medicine_english_commercial_name'] = medicineEnglishCommercialName;
    data['medicine_arabic_commercial_name'] = medicineArabicCommercialName;
    data['total_quantity'] = totalQuantity;
    data['price_when_ordered'] = priceWhenOrdered;
    data['total_price'] = totalPrice;
    data['has_discount'] = hasDiscount;
    return data;
  }
}
