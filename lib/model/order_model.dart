import '../core/enums/order_status.dart';

class OrderModel {
  int? id;
  String? pharmacistUsername;
  OrderStatus? orderStatus;
  int? paymentStatus;
  int? totalQuantity;
  double? totalPrice;
  String? receivedAt;
  String? hasCanceled;
  String? createdAt;

  OrderModel(
      {this.id,
        this.pharmacistUsername,
        this.orderStatus,
        this.paymentStatus,
        this.totalQuantity,
        this.totalPrice,
        this.receivedAt,
        this.hasCanceled,
        this.createdAt});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pharmacistUsername = json['pharmacist_username'];
    orderStatus = OrderStatus.parse(json['order_status']);
    paymentStatus = json['payment_status'];
    totalQuantity = json['total_quantity'];
    totalPrice = double.parse(json['total_price'].toString());
    receivedAt = json['received_at'];
    hasCanceled = json['has_canceled'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pharmacist_username'] = pharmacistUsername;
    data['order_status'] = orderStatus;
    data['payment_status'] = paymentStatus;
    data['total_quantity'] = totalQuantity;
    data['total_price'] = totalPrice;
    data['received_at'] = receivedAt;
    data['has_canceled'] = hasCanceled;
    data['created_at'] = createdAt;
    return data;
  }
}
