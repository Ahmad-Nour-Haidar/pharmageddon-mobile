import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_mobile/controllers/order_cubit/order_cubit.dart';
import 'package:pharmageddon_mobile/core/class/parent_state.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/print.dart';

import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitialState());

  static NotificationCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> initial() async {
    FirebaseMessaging.onMessage.listen(_handleNotification);
  }

  // 1. new order
  // 2. cancel order
  // 3. the order has been sent
  // 4. the order has been received
  // 5. new medication

  void _handleNotification(RemoteMessage message) {
    printme.blue(message.data);
    emit(NewNotification(ShowNotification(message: message.data.toString())));
    final action = message.data['action'].toString();
    switch (action) {
      case '1':
        AppInjection.getIt<OrderCubit>().getAll(forceGetData: true);
        break;
      case '2':
        AppInjection.getIt<OrderCubit>().getAll(forceGetData: true);
        break;
      case '3':
        AppInjection.getIt<OrderCubit>().getAll(forceGetData: true);
        break;
      case '4':
        AppInjection.getIt<OrderCubit>().getAll(forceGetData: true);
        break;
      case '5':
        AppInjection.getIt<HomeCubit>().getMedications(forceGetData: true);
        break;
    }
  }
}
