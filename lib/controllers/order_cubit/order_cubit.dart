import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import '../../data/remote/order_data.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitialState());

  static OrderCubit get(BuildContext context) => BlocProvider.of(context);
  final orderRemoteData = AppInjection.getIt<OrderRemoteData>();

  void _update(OrderState state) {
    if (isClosed) return;
    emit(state);
  }
}
