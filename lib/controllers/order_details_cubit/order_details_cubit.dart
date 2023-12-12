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

  void _update(OrderDetailsState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial(OrderModel model) {
    this.model = model;
    getDetails();
  }

  Future<void> getDetails() async {
    _update(OrderDetailsLoadingState());
    final queryParameters = {
      AppRKeys.id: model.id,
    };
    final response = await _orderRemoteData.getOrderDetails(
      queryParameters: queryParameters,
    );
    response.fold((l) {
      _update(OrderDetailsFailureState(l));
    }, (r) {
      // final List temp = r[AppRKeys.data][AppRKeys.medicines];
      data.clear();
      data.addAll(List.generate(10, (index) => OrderDetailsModel()));
      _update(OrderDetailsSuccessState());
    });
  }

  Future<void> cancel() async {
    _update(OrderDetailsLoadingCancelState());
    final data = {
      AppRKeys.id: model.id,
    };
    final response = await _orderRemoteData.cancel(data: data);
    response.fold((l) {
      _update(OrderDetailsFailureState(l));
    }, (r) {
      AppInjection.getIt<OrderCubit>().removeFromList(model);
      _update(OrderDetailsSuccessCancelState());
    });
  }
}
