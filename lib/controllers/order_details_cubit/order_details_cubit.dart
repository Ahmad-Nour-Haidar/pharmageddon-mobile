import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/class/parent_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_text.dart';
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
  late OrderModel model;
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
    final queryParameters = {
      AppRKeys.id: model.id,
    };
    final response = await _orderRemoteData.deleteMedicineInOrder(
        queryParameters: queryParameters);
    response.fold((l) {
      _update(OrderDetailsFailureState(l));
    }, (r) {
      final status = r[AppRKeys.status];
      if (status == 403) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderNotFound.tr,
        )));
        return;
      }
      if (status == 405) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.thisOrderHasCanceledBefore.tr,
        )));
        return;
      }
      if (status == 406) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderHasBeenSentSoYouCannotCancelIt.tr,
        )));
        return;
      }
      if (status == 408) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderHasReceivedSoYouCannotCancelIt.tr,
        )));
        return;
      }
      if (status == 200) {
        AppInjection.getIt<OrderCubit>().removeOrderFromList(model);
        _update(OrderDetailsSuccessCancelState());
      }
    });
  }

  Future<void> onTapDeleteMedicine(int id) async {
    _update(OrderDetailsLoadingDeleteMedicineState());
    final queryParameters = {
      AppRKeys.order_id: model.id,
      AppRKeys.medicine_id: id,
    };
    final response = await _orderRemoteData.deleteMedicineInOrder(
      queryParameters: queryParameters,
    );
    response.fold((l) {
      _update(OrderDetailsFailureState(l));
    }, (r) async {
      final status = r[AppRKeys.status];
      if (status == 403) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderNotFound.tr,
        )));
        return;
      }
      if (status == 405) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.thisOrderHasCanceledBefore.tr,
        )));
        return;
      }
      if (status == 406) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderHasBeenSentSoYouCannotEditIt.tr,
        )));
        return;
      }
      if (status == 408) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderHasReceivedSoYouCannotEditIt.tr,
        )));
        return;
      }
      if (status == 409) {
        _update(OrderDetailsFailureState(FailureState(
          message:
              AppText.eitherThereIsNoMedicineWithThisIDOrYouHaveNotOrderedIt.tr,
        )));
        return;
      }
      if (status == 201) {
        _update(OrderDetailsAllCanceledState());
      }
      if (status == 200) {
        data.removeWhere((element) => element.medicineId == id);
        model = OrderModel.fromJson(r[AppRKeys.data][AppRKeys.order]);
        await AppInjection.getIt<OrderCubit>().updateOrderInList(model);
        _update(OrderDetailsDeleteMedicineSuccessState(
            SuccessState(message: AppText.medicineCanceledSuccessfully.tr)));
      }
    });
  }

  bool get isEdit => _isEdit;

  set isEdit(bool value) {
    _isEdit = value;
    if (!_isEdit) {
      tempQuantity.clear();
    }
    _update(OrderDetailsChangeState());
  }

  Future<void> updateOrder() async {
    isEdit = false;
    _update(OrderDetailsUpdateOrderLoadingState());
  }

  void onEditMedicine(int id, int newQuantity) {
    tempQuantity[id] = newQuantity;
    _update(OrderDetailsChangeState());
  }

  int getQuantityOfMedicine(OrderDetailsModel model) {
    return tempQuantity[model.medicineId!] ?? model.totalQuantity!;
  }
}
