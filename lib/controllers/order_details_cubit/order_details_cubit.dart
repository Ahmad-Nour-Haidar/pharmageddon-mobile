import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/model/order_model.dart';
import '../../core/constant/app_request_keys.dart';
import '../../data/remote/order_data.dart';
import '../../model/order_details_model.dart';
import '../order_cubit/order_cubit.dart';
import 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsInitialState());

  static OrderDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final _orderRemoteData = AppInjection.getIt<OrderRemoteData>();
  final List<OrderDetailsModel> data = [];
  late final OrderModel model;
  final Map<int, int> tempQuantity = {};
  bool _isEdit = false;

  void _update(OrderDetailsState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial(OrderModel model) {
    this.model = model;
    _update(OrderDetailsSuccessState());
    getDetails();
  }

  int getQuantityOfMedicine(OrderDetailsModel model) {
    return tempQuantity[model.medicineId!] ?? model.totalQuantity!;
  }

  int get totalQuantity {
    int x = 0;
    for (final e in data) {
      x += getQuantityOfMedicine(e);
    }
    if (x == 0) {
      x = model.totalQuantity!;
    }
    return x;
  }

  double get totalPrice {
    double x = 0.0;
    for (final e in data) {
      double p = e.priceWhenOrdered! * getQuantityOfMedicine(e);
      x += p;
    }
    if (x == 0) {
      x = model.totalPrice!;
    }
    return x;
  }

  Future<void> getDetails() async {
    _update(OrderDetailsGetLoadingState());
    final queryParameters = {
      AppRKeys.id: model.id,
    };
    final response = await _orderRemoteData.getOrderDetails(
      queryParameters: queryParameters,
    );
    response.fold((l) {
      _update(OrderDetailsFailureState(l));
    }, (r) {
      final List temp =
          r[AppRKeys.data][AppRKeys.order][AppRKeys.order_details];
      data.clear();
      data.addAll(temp.map((e) => OrderDetailsModel.fromJson(e)));
      _update(OrderDetailsSuccessState());
    });
  }

  Future<void> cancel() async {
    _update(OrderDetailsLoadingCancelState());
    final data = {AppRKeys.id: model.id};
    final response = await _orderRemoteData.cancel(data: data);
    response.fold((l) {
      _update(OrderDetailsFailureState(l));
    }, (r) {
      AppInjection.getIt<OrderCubit>().removeFromList(model);
      _update(OrderDetailsSuccessCancelState());
    });
  }

  Future<bool> update() async {
    bool isEdit = false;
    _update(OrderDetailsLoadingCancelState());
    await Future.delayed(const Duration(seconds: 4));
    final List<Map<String, int>> list = [];
    for (final e in data) {
      list.add({
        AppRKeys.medicine_id: e.medicineId!,
        AppRKeys.quantity: getQuantityOfMedicine(e),
      });
    }
    final requestData = {AppRKeys.medicines: list};
    final response = await _orderRemoteData.cancel(data: requestData);
    response.fold((l) {
      _update(OrderDetailsFailureState(l));
    }, (r) {});
    return isEdit;
  }

  void onEditMedicine(int id, int newQuantity) {
    tempQuantity[id] = newQuantity;
    _update(OrderDetailsChangeState());
  }

  bool get isEdit => _isEdit;

  set isEdit(bool value) {
    _isEdit = value;
    if (!_isEdit) {
      tempQuantity.clear();
    }
    _update(OrderDetailsChangeState());
  }
}
