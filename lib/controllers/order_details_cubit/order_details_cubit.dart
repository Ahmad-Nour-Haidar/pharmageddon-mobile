import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/class/parent_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_text.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/model/order_model.dart';
import '../../core/constant/app_request_keys.dart';
import '../../data/remote/order_data.dart';
import '../../model/medicines_quantity_not_available_model.dart';
import '../../model/order_details_model.dart';
import '../home_cubit/home_cubit.dart';
import '../order_cubit/order_cubit.dart';
import 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsInitialState());

  static OrderDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final _orderRemoteData = AppInjection.getIt<OrderRemoteData>();
  final List<OrderDetailsModel> data = [];
  late OrderModel model;
  bool _isEdit = false;

  // this used to edit order
  final Map<int, int> _tempQuantity = {};

  // this used if there medicines quantity not available
  final List<MedicinesQuantityNotAvailableModel> dataNotAvailable = [];

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

  Future<void> cancelOrder() async {
    _update(OrderDetailsLoadingCancelState());
    final queryParameters = {
      AppRKeys.id: model.id,
    };
    final response =
        await _orderRemoteData.cancelOrder(queryParameters: queryParameters);
    response.fold((l) {
      _update(OrderDetailsFailureState(l));
    }, (r) {
      final status = r[AppRKeys.status];
      if (status == 403) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderNotFound.tr,
        )));
      } else if (status == 405) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.thisOrderHasCanceledBefore.tr,
        )));
      } else if (status == 406) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderHasBeenSentSoYouCannotCancelIt.tr,
        )));
      } else if (status == 408) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderHasReceivedSoYouCannotCancelIt.tr,
        )));
      } else if (status == 200) {
        // to update Order List
        AppInjection.getIt<OrderCubit>().removeOrderFromList(model);
        _update(OrderDetailsSuccessCancelState());
        // to update Home List Medications
        AppInjection.getIt<HomeCubit>().getMedications(
          forceGetData: true,
          showState: false,
        );
      }
    });
  }

  Future<void> onTapDeleteMedicine(int id) async {
    _update(OrderDetailsDeleteMedicineLoadingState());
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
        // to update Home List Medications
        AppInjection.getIt<HomeCubit>().getMedications(
          forceGetData: true,
          showState: false,
        );
        return;
      }
      if (status == 200) {
        data.removeWhere((element) => element.medicineId == id);
        model = OrderModel.fromJson(r[AppRKeys.data][AppRKeys.order]);
        await AppInjection.getIt<OrderCubit>().updateOrderInList(model);
        _update(OrderDetailsDeleteMedicineSuccessState(
            SuccessState(message: AppText.medicineCanceledSuccessfully.tr)));
        // to update Home List Medications
        AppInjection.getIt<HomeCubit>().getMedications(
          forceGetData: true,
          showState: false,
        );
      }
    });
  }

  bool get isEdit => _isEdit;

  set isEdit(bool value) {
    _isEdit = value;
    _update(OrderDetailsChangeState());
  }

  Future<void> updateOrder() async {
    isEdit = false;
    dataNotAvailable.clear();
    _update(OrderDetailsUpdateOrderLoadingState());
    if (_tempQuantity.isEmpty) return;
    final List<Map<String, int>> list = [];
    for (final e in data) {
      final q = _tempQuantity[e.medicineId] ?? e.totalQuantity;
      list.add({
        AppRKeys.medicine_id: e.medicineId!,
        AppRKeys.quantity: q!,
      });
    }
    _tempQuantity.clear();
    final requestData = {
      AppRKeys.id: model.id,
      AppRKeys.medicines: list,
    };
    final response = await _orderRemoteData.updateOrder(data: requestData);
    response.fold((l) {
      _update(OrderDetailsFailureState(l));
    }, (r) async {
      final status = r[AppRKeys.status];
      if (status == 403) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderNotFound.tr,
        )));
        // to update Order List
        AppInjection.getIt<OrderCubit>().getAll(
          forceGetData: true,
          showState: false,
        );
        return;
      }
      if (status == 404) {
        // todo
        final List tempList =
            r[AppRKeys.data][AppRKeys.medicines_quantity_not_available];
        dataNotAvailable.clear();
        dataNotAvailable.addAll(tempList
            .map((e) => MedicinesQuantityNotAvailableModel.fromJson(e)));
        AppInjection.getIt<HomeCubit>()
            .updateQuantityListMedications(dataNotAvailable);
        _update(OrderDetailsFailureState(FailureState(
            message: AppText.quantitiesOfSomeMedicinesAreNotAvailable.tr)));
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
      if (status == 200) {
        model = OrderModel.fromJson(r[AppRKeys.data][AppRKeys.order]);
        await AppInjection.getIt<OrderCubit>().updateOrderInList(model);
        final List temp =
            r[AppRKeys.data][AppRKeys.order][AppRKeys.order_details];
        data.clear();
        data.addAll(temp.map((e) => OrderDetailsModel.fromJson(e)));
        _update(OrderDetailsUpdateOrderSuccessState(
            SuccessState(message: AppText.updatedSuccessfully.tr)));
        // to update Home List Medications
        AppInjection.getIt<HomeCubit>().getMedications(
          forceGetData: true,
          showState: false,
        );
        return;
      }
    });
  }

  Future<void> updateOrderStatus(String status) async {
    _update(OrderDetailsUpdateOrderLoadingState());
    final requestData = {
      AppRKeys.id: model.id,
      AppRKeys.order_status: status,
    };
    final response =
        await _orderRemoteData.updateOrderStatus(data: requestData);
    response.fold((l) {
      _update(OrderDetailsFailureState(l));
    }, (r) async {
      final status = r[AppRKeys.status];
      if (status == 403) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderNotFound.tr,
        )));
        // to update Order List
        AppInjection.getIt<OrderCubit>().getAll(
          forceGetData: true,
          showState: false,
        );
        return;
      }
      if (status == 405) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.thisOrderHasAlreadyBeenCanceled.tr,
        )));
        return;
      }
      if (status == 408) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.thisOrderHasAlreadyBeenReceived.tr,
        )));
        return;
      }
      if (status == 200) {
        await AppInjection.getIt<OrderCubit>().getAll(
          forceGetData: true,
          showState: false,
        );
        _update(OrderDetailsUpdateStatusOrderSuccessState());
        return;
      }
    });
  }

  void onEditMedicine(int id, int newQuantity) {
    _tempQuantity[id] = newQuantity;
    _update(OrderDetailsChangeState());
  }

  int getQuantityOfMedicine(OrderDetailsModel model) {
    return _tempQuantity[model.medicineId!] ?? model.totalQuantity!;
  }
}
