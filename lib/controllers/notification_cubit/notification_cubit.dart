import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/print.dart';

import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitialState());

  static NotificationCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }

  Future<void> init() async {
    initial();
  }

  Future<void> initial() async {
    FirebaseMessaging.onMessage.listen(_handleNotification);
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // 1. new order
  // 2. cancel order
  // 3. the order has been sent
  // 4. the order has been received
  // 5. new medication

  void _handleNotification(RemoteMessage message) async {
    printme.green('onMessage');
    printme.blue(message.data);
    printme.blue(message.notification?.title);
    printme.blue(message.notification?.body);
    printme.green('onMessage');
    AwesomeNotifications().createNotification(
        actionButtons: [
          NotificationActionButton(key: 'OK', label: 'Ok'),
          NotificationActionButton(key: 'YES', label: 'Yes'),
          NotificationActionButton(
            key: 'DISMISS',
            label: 'Dismiss',
            actionType: ActionType.DismissAction,
            isDangerousOption: true,
          )
        ],
        content: NotificationContent(
          id: Random().nextInt(1000),
          channelKey: 'basic_channel',
          // groupKey: 'basic_channel_group',
          actionType: ActionType.Default,
          title: message.notification?.title,
          body:
              'message.notification?.bodymessage.notification?.bodymessage.notification?.bodymessage.notification?.body message.notification?.body message.notification?.body',
          color: AppColor.snackbarColor,
          backgroundColor: AppColor.blue2,
          notificationLayout: NotificationLayout.BigText,
        ));

    // emit(NewNotification(ShowNotification(message: message.data.toString())));

    // final action = message.data['action'].toString();
    // switch (action) {
    //   case '1':
    //     AppInjection.getIt<OrderCubit>().getAll(forceGetData: true);
    //     break;
    //   case '2':
    //     AppInjection.getIt<OrderCubit>().getAll(forceGetData: true);
    //     break;
    //   case '3':
    //     AppInjection.getIt<OrderCubit>().getAll(forceGetData: true);
    //     break;
    //   case '4':
    //     AppInjection.getIt<OrderCubit>().getAll(forceGetData: true);
    //     break;
    //   case '5':
    //     AppInjection.getIt<HomeCubit>().getMedications(forceGetData: true);
    //     break;
    // }
  }
}
