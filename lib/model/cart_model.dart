import 'package:pharmageddon_mobile/model/medication_model.dart';

class CartModel {
  final MedicationModel medicationModel;
  int quantity;

  double get totalPrice => quantity * medicationModel.priceAfterDiscount!;

  CartModel({
    required this.quantity,
    required this.medicationModel,
  });
}
