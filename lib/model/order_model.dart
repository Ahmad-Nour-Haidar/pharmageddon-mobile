import 'dart:math';

import 'package:pharmageddon_mobile/core/enums/order_status.dart';

class OrderModel {
  final OrderStatus status;

  OrderModel(this.status);

  final id = Random().nextInt(5) + 1;
  final totalQ = 14;
  final totalP = Random().nextInt(12500) + 12500;
  final payment = true;
  final date = '2023-12-09 00:00:00.000';
}
