import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/enums/order_status.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/print.dart';
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
    getData();
  }

  Future<void> getData({bool forceGetData = false}) async {
    if (!(data.isEmpty || forceGetData)) {
      _update(OrderSuccessState());
      return;
    }
    printme.cyan('_initialData');
    List<OrderModel> temp = [
      OrderModel(OrderStatus.preparing),
      OrderModel(OrderStatus.preparing),
      OrderModel(OrderStatus.hasBeenSent),
      OrderModel(OrderStatus.hasBeenSent),
      OrderModel(OrderStatus.hasBeenSent),
      OrderModel(OrderStatus.hasBeenSent),
    ];
    _update(OrderLoadingState());
    final response = await _orderRemoteData.getOrders();
    await Future.delayed(const Duration(seconds: 4));
    response.fold((l) {
      _update(OrderFailureState(l));
    }, (r) {
      _preparingOrders.clear();
      _hasBeenSentOrders.clear();
      _receivedOrders.clear();
      for (final e in temp) {
        if (e.status == OrderStatus.received) {
          _receivedOrders.add(e);
        } else if (e.status == OrderStatus.preparing) {
          _preparingOrders.add(e);
        } else {
          _hasBeenSentOrders.add(e);
        }
      }
      _update(OrderSuccessState());
      printme.cyan(temp.length);
      printme.cyan(_preparingOrders.length);
      printme.cyan(_hasBeenSentOrders.length);
      printme.cyan(_receivedOrders.length);
    });
  }

  int get indexScreen => _indexScreen;

  set indexScreen(int value) {
    _indexScreen = value;
    _update(OrderSuccessState());
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
}
