import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/core/constant/app_link.dart';
import 'package:pharmageddon_mobile/core/constant/app_request_keys.dart';
import 'package:pharmageddon_mobile/core/enums/order_status.dart';
import 'package:pharmageddon_mobile/core/enums/screens.dart';
import 'package:pharmageddon_mobile/core/extensions/update_list.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import '../../data/remote/order_data.dart';
import '../../model/order_model.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitialState());

  /// 0.preparing 1.hasBeenSent 2.received

  static OrderCubit get(BuildContext context) => BlocProvider.of(context);
  final _orderRemoteData = AppInjection.getIt<OrderRemoteData>();
  final List<OrderModel> _preparingOrders = [];
  final List<OrderModel> _hasBeenSentOrders = [];
  final List<OrderModel> _receivedOrders = [];
  var currentScreen = ScreenShow.preparing;

  void _update(OrderState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial() {
    getAll();
  }

  Future<void> getAll({bool forceGetData = false}) async {
    if (!(_preparingOrders.isEmpty || forceGetData)) return;
    _update(OrderLoadingState());
    final response = await _orderRemoteData.getOrders(
      url: AppLink.orderGetAllNotCanceled,
    );
    response.fold((l) {
      _update(OrderFailureState(l));
    }, (r) {
      final List temp = r[AppRKeys.data][AppRKeys.orders];
      _preparingOrders.clear();
      _hasBeenSentOrders.clear();
      _receivedOrders.clear();
      for (final e in temp) {
        final order = OrderModel.fromJson(e);
        if (order.orderStatus == OrderStatus.preparing) {
          _preparingOrders.add(order);
        } else if (order.orderStatus == OrderStatus.hasBeenSent) {
          _hasBeenSentOrders.add(order);
        } else {
          _receivedOrders.add(order);
        }
      }
      _update(OrderSuccessState());
    });
  }

  Future<void> getPreparing({bool forceGetData = false}) async {
    if (!(_preparingOrders.isEmpty || forceGetData)) return;
    _update(OrderLoadingState());
    final response = await _orderRemoteData.getOrders(
      url: AppLink.orderGetAllPreparing,
    );
    response.fold((l) {
      _update(OrderFailureState(l));
    }, (r) {
      final List temp = r[AppRKeys.data][AppRKeys.orders];
      _preparingOrders.clear();
      _preparingOrders.addAll(temp.map((e) => OrderModel.fromJson(e)));
      _update(OrderSuccessState());
    });
  }

  Future<void> getHasBeenSent({bool forceGetData = false}) async {
    if (!(_hasBeenSentOrders.isEmpty || forceGetData)) return;
    _update(OrderLoadingState());
    final response = await _orderRemoteData.getOrders(
      url: AppLink.orderGetAllSent,
    );
    response.fold((l) {
      _update(OrderFailureState(l));
    }, (r) {
      final List temp = r[AppRKeys.data][AppRKeys.orders];
      _hasBeenSentOrders.clear();
      _hasBeenSentOrders.addAll(temp.map((e) => OrderModel.fromJson(e)));
      _update(OrderSuccessState());
    });
  }

  Future<void> getReceived({bool forceGetData = false}) async {
    if (!(_receivedOrders.isEmpty || forceGetData)) return;
    _update(OrderLoadingState());
    final response = await _orderRemoteData.getOrders(
      url: AppLink.orderGetAllReceived,
    );
    response.fold((l) {
      _update(OrderFailureState(l));
    }, (r) {
      final List temp = r[AppRKeys.data][AppRKeys.orders];
      _receivedOrders.clear();
      _receivedOrders.addAll(temp.map((e) => OrderModel.fromJson(e)));
      _update(OrderSuccessState());
    });
  }

  List<OrderModel> get data {
    if (currentScreen == ScreenShow.preparing) return _preparingOrders;
    if (currentScreen == ScreenShow.hasBeenSent) return _hasBeenSentOrders;
    return _receivedOrders;
  }

  void changeScreen(ScreenShow s) {
    currentScreen = s;
    _update(OrderChangeState());
  }

  Future<void> removeOrderFromList(OrderModel model) async {
    if (_preparingOrders.isEmpty) return;
    _preparingOrders.removeWhere((element) => element.id == model.id);
    _update(OrderSuccessState());
  }

  Future<void> updateOrderInList(OrderModel model) async {
    if (_preparingOrders.isEmpty) return;
    final index =
        _preparingOrders.indexWhere((element) => element.id == model.id);
    _preparingOrders.update(index, model);
    _update(OrderSuccessState());
  }
}
