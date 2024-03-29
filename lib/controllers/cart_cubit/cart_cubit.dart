import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_mobile/controllers/order_cubit/order_cubit.dart';
import 'package:pharmageddon_mobile/core/class/parent_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_request_keys.dart';
import 'package:pharmageddon_mobile/core/constant/app_text.dart';
import 'package:pharmageddon_mobile/core/notifications/app_firebase.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/data/local/cart_quantity_data.dart';
import 'package:pharmageddon_mobile/print.dart';
import '../../data/remote/order_data.dart';
import '../../model/cart_model.dart';
import '../../model/medicines_quantity_not_available_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  static CartCubit get(BuildContext context) => BlocProvider.of(context);
  final _cartQuantityData = AppInjection.getIt<CartQuantityData>();
  final _homeCubit = AppInjection.getIt<HomeCubit>();
  final _orderRemoteData = AppInjection.getIt<OrderRemoteData>();
  final List<CartModel> data = [];
  bool _isSendingRequest = false;

  // this used if there medicines quantity not available
  final List<MedicinesQuantityNotAvailableModel> dataNotAvailable = [];

  void _update(CartState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial() {
    _initialData();
  }

  Future<void> _initialData() async {
    try {
      final ids = _cartQuantityData.getIds();
      data.clear();
      data.addAll(ids.map((id) {
        final model = _homeCubit.medicationsMap[id]!;
        final cartQ = _cartQuantityData.getQuantityOfModel(id);
        var q = min(cartQ, model.availableQuantity!);
        if (q != cartQ) {
          _cartQuantityData.storeInCart(id, q);
        }
        return CartModel(quantity: q, medicationModel: model);
      }));
      _update(CartInitialDataSuccessState());
    } catch (e) {
      printme.red(e);
      _update(CartInitialDataFailureState(FailureState()));
    }
  }

  Future<void> createOrder() async {
    if (this.data.isEmpty) {
      _update(CartFailureState(
        WarningState(message: AppText.yourBillIsEmpty.tr),
      ));
      return;
    }
    dataNotAvailable.clear();
    _isSendingRequest = true;
    _update(CartLoadingState());
    final data = await _cartQuantityData.dataToRequest();
    final response = await _orderRemoteData.createOrder(data: data);
    _isSendingRequest = false;
    response.fold((l) {
      _update(CartFailureState(l));
    }, (r) async {
      final status = r[AppRKeys.status];
      if (status == 404) {
        final List tempList =
            r[AppRKeys.data][AppRKeys.medicines_quantity_not_available];
        dataNotAvailable.clear();
        dataNotAvailable.addAll(tempList
            .map((e) => MedicinesQuantityNotAvailableModel.fromJson(e)));
        AppInjection.getIt<HomeCubit>()
            .updateQuantityListMedications(dataNotAvailable);
        _update(CartFailureState(FailureState(
            message: AppText.quantitiesOfSomeMedicinesAreNotAvailable.tr)));
      } else if (status == 405) {
        _update(CartFailureState(
            FailureState(message: AppText.someOfMedicinesAreExpired.tr)));
      } else if (status == 200) {
        this.data.clear();
        _cartQuantityData.deleteAllCart();
        _update(CartSuccessState());
        // to update Order List
        AppInjection.getIt<OrderCubit>().getAll(
          forceGetData: true,
          showState: false,
        );
        AppFirebase.handleNotification(
          titleNotification: AppText.newOrder.tr,
          bodyNotification: AppText.theOrderHasBeenAddedSuccessfully.tr,
        );
      } else {
        _update(CartFailureState(FailureState()));
      }
      // to update Home List Medications
      AppInjection.getIt<HomeCubit>().getMedications(
        forceGetData: true,
        showState: false,
      );
    });
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

  void onTapRemove(int? id) {
    if (_isSendingRequest) return;
    try {
      _cartQuantityData.storeInCart(id, 0);
      data.removeWhere((element) => element.medicationModel.id == id);
      dataNotAvailable.removeWhere((element) => element.medicineId == id);
      _update(CartSuccessState());
    } catch (e) {
      _update(CartFailureState(null));
    }
  }

  void changeQuantityOfModel(int? id, int newQuantity) {
    if (_isSendingRequest) return;
    try {
      _cartQuantityData.storeInCart(id, newQuantity);
      final index =
          data.indexWhere((element) => element.medicationModel.id == id);
      data[index].quantity = newQuantity;
      _update(CartSuccessState());
    } catch (e) {
      _update(CartFailureState(null));
    }
  }
}
