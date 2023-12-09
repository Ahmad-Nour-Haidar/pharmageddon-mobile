import 'dart:math';

import 'package:pharmageddon_mobile/core/enums/order_status.dart';

class OrderModel {
  final OrderStatus status;

  OrderModel(this.status);

  final date = '2023-12-09 00:00:00.000';
  final id = Random().nextInt(5) + 1;
  final totalQ = 14;
  final totalP = 144.0;
  final payment = true;
}
