import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_mobile/core/class/parent_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/data/local/cart_quantity_data.dart';
import 'package:pharmageddon_mobile/data/remote/cart_data.dart';
import 'package:pharmageddon_mobile/print.dart';
import '../../model/cart_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  static CartCubit get(BuildContext context) => BlocProvider.of(context);
  final cartQuantityData = AppInjection.getIt<CartQuantityData>();
  final homeCubit = AppInjection.getIt<HomeCubit>();
  final cartRemoteData = AppInjection.getIt<CartRemoteData>();
  final List<CartModel> data = [];

  void _update(CartState state) {
    if (isClosed) return;
    emit(state);
  }

  Future<void> order() async {
    printme.cyan(this.data.isEmpty);
    if (this.data.isEmpty) {
      _update(CartFailureState(
          WarningState(message: AppStrings.yourBillIsEmpty.tr)));
      return;
    }
    _update(CartLoadingState());
    final data = await cartQuantityData.dataToRequest();
    final response = await cartRemoteData.order(data: data);
    response.fold((l) {
      _update(CartFailureState(l));
    }, (r) {});
  }

  void initial() {
    initialData();
  }

  Future<void> initialData() async {
    try {
      final ids = cartQuantityData.getIds();
      data.clear();
      data.addAll(ids.map((id) => CartModel(
            quantity: cartQuantityData.getQuantityOfModel(id),
            medicationModel: homeCubit.medicationsMap[id]!,
          )));
      _update(CartInitialDataSuccessState());
    } catch (e) {
      printme.red(e);
      _update(CartInitialDataFailureState(FailureState()));
    }
  }

  int get totalQuantity {
    int q = 0;
    for (final element in data) {
      q += element.quantity;
    }
    return q;
  }

  double get totalPrice {
    double p = 0.0;
    for (final element in data) {
      p += element.totalPrice;
    }
    return p;
  }

  void change() {
    _update(CartChangeState());
  }
}
