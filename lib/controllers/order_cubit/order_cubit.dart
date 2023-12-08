import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/core/constant/app_request_keys.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/print.dart';
import '../../data/remote/order_data.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitialState());

  static OrderCubit get(BuildContext context) => BlocProvider.of(context);
  final orderRemoteData = AppInjection.getIt<OrderRemoteData>();

  Future<void> order() async {
    final data = {
      'medicines': [
        {
          'medicine_id': 5,
          'quantity': 10,
        },
        {
          'medicine_id': 6,
          'quantity': 10,
        },
      ],
    };
    final response = await orderRemoteData.order(data: data);
    printme.printFullText(response);
    response.fold((l) {
      emit(OrderFailureState(l));
    }, (r) {
      final status = r[AppRKeys.status];
    });
  }
}
