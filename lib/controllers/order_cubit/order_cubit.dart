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
    // _initialData();
  }

  int get indexScreen => _indexScreen;
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

  set initialIndexScreen(int value) {
    _indexScreen = value;
  }

  Future<void> _initialData({bool forceGetData = false}) async {
    if (!(data.isEmpty || forceGetData)) {
      _update(OrderSuccessState());
      return;
    }

    List<OrderModel> temp = [
      OrderModel(OrderStatus.preparing),
      OrderModel(OrderStatus.preparing),
      OrderModel(OrderStatus.hasBeenSent),
      OrderModel(OrderStatus.hasBeenSent),
      OrderModel(OrderStatus.hasBeenSent),
      OrderModel(OrderStatus.received),
    ];

    final response = await _orderRemoteData.getOrders();
    response.fold((l) {
      _update(OrderFailureState(l));
    }, (r) {
      for (final e in temp) {
        if (e.status == OrderStatus.received) {
          _receivedOrders.add(e);
        } else if (e.status == OrderStatus.preparing) {
          _preparingOrders.add(e);
        } else {
          _hasBeenSentOrders.add(e);
        }
      }
      printme.cyan(temp.length);
      printme.cyan(_preparingOrders.length);
      printme.cyan(_hasBeenSentOrders.length);
      printme.cyan(_receivedOrders.length);
    });
  }
}
