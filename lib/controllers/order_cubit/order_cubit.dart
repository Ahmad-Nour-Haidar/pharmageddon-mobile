import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/core/constant/app_link.dart';
import 'package:pharmageddon_mobile/core/constant/app_request_keys.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
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
  int _indexScreen = 0;

  void _update(OrderState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial() {
    getPreparing();
  }

  Future<void> getPreparing({bool forceGetData = false}) async {
    if (!(_preparingOrders.isEmpty || forceGetData)) {
      _update(OrderSuccessState());
      return;
    }
    _update(OrderLoadingState());
    final response = await _orderRemoteData.getOrders(
      url: AppLink.getAllPreparing,
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
    if (!(_hasBeenSentOrders.isEmpty || forceGetData)) {
      _update(OrderSuccessState());
      return;
    }
    _update(OrderLoadingState());
    final response = await _orderRemoteData.getOrders(
      url: AppLink.getAllSent,
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
    if (!(_receivedOrders.isEmpty || forceGetData)) {
      _update(OrderSuccessState());
      return;
    }
    _update(OrderLoadingState());
    final response = await _orderRemoteData.getOrders(
      url: AppLink.getAllReceived,
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

  int get indexScreen => _indexScreen;

  set indexScreen(int value) {
    _indexScreen = value;
    _update(OrderChangeState());
    getData();
  }

  final _titles = [
    AppStrings.preparing,
    AppStrings.hasBeenSent,
    AppStrings.received,
  ];

  String get title => _titles[indexScreen];

  List<OrderModel> get data {
    if (_indexScreen == 0) return _preparingOrders;
    if (_indexScreen == 1) return _hasBeenSentOrders;
    return _receivedOrders;
  }

  void getData() {
    if (_indexScreen == 0) {
      getPreparing(forceGetData: true);
    } else if (_indexScreen == 1) {
      getHasBeenSent(forceGetData: true);
    } else {
      getReceived(forceGetData: true);
    }
  }

  Future<void> removeFromList(OrderModel model) async {
    if (_preparingOrders.isEmpty) return;
    _preparingOrders.removeWhere((element) => element.id == model.id);
    _update(OrderSuccessState());
  }
}
