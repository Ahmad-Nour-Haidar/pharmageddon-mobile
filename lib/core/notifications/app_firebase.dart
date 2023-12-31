import 'dart:convert';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
import 'package:pharmageddon_mobile/core/constant/app_request_keys.dart';
import 'package:pharmageddon_mobile/core/notifications/app_notifications_keys.dart';
import 'package:pharmageddon_mobile/print.dart';

import '../../controllers/home_cubit/home_cubit.dart';
import '../../controllers/order_cubit/order_cubit.dart';
import '../../firebase_options.dart';
import '../constant/app_color.dart';
import '../constant/app_local_data.dart';
import '../services/dependency_injection.dart';

class AppFirebase {
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // printme.cyan('================== onBackgroundMessage ================');
    // printme.cyan('title = ${message.notification?.title}');
    // printme.cyan('body = ${message.notification?.body}');
    // printme.cyan('data = ${message.data}');
    // printme.cyan('================== onBackgroundMessage ================');
    // _handleNotification(message);
  }

  static Future<void> firebaseMessaging(RemoteMessage message) async {
    // printme.cyan('================== onMessage ================');
    // printme.cyan('title = ${message.notification?.title}');
    // printme.cyan('body = ${message.notification?.body}');
    // printme.cyan('body = ${message.data}');
    // printme.cyan('================== onMessage ================');

    final data = json.decode(message.data[AppRKeys.data]);
    final action = message.data[AppRKeys.action].toString();
    handleNotification(
      titleNotification: message.notification?.title,
      bodyNotification: message.notification?.body,
      data: data,
      action: action,
    );
    _handleActions(action);
  }

  static final _awesomeNotifications = AwesomeNotifications();

  static Future<void> handleNotification({
    String? titleNotification,
    String? bodyNotification,
    String? action,
    Map<String, dynamic>? data,
  }) async {
    final title = titleNotification ?? 'Pharmageddon';
    var body = bodyNotification ?? 'New notification';
    if ((action == '4' || action == '5' || action == '6' || action == '7') &&
        data != null) {
      final orderId = data[AppRKeys.order_id];
      body = 'ID: $orderId , $body';
    }
    _awesomeNotifications.createNotification(
      content: NotificationContent(
        id: Random().nextInt(1000),
        channelKey: AppNKeys.channelKey,
        // groupKey: AppNKeys.groupKey,
        actionType: ActionType.Default,
        title: title,
        body: body,
        color: AppColor.snackbarColor,
        backgroundColor: AppColor.blue2,
        notificationLayout: NotificationLayout.BigText,
      ),
      // actionButtons: [
      //   NotificationActionButton(key: 'Done', label: 'Done'),
      //   NotificationActionButton(
      //     key: 'Dismiss',
      //     label: 'Dismiss',
      //     actionType: ActionType.DismissAction,
      //     isDangerousOption: true,
      //   )
      // ],
    );
  }

  // 1 Create an order
  // 2 Modify an order
  // 3 Cancellation of a medication included in an order
  // 4 Cancel an order
  // 5 Send an order
  // 6 Receiving an order
  // 7 Pay an order
  // 8 Create a medicine
  static Future<void> _handleActions(String action) async {
    if (action == '4' || action == '5' || action == '6' || action == '7') {
      AppInjection.getIt<OrderCubit>().getAll(
        forceGetData: true,
        showState: false,
      );
    }
    if (action == '8') {
      AppInjection.getIt<HomeCubit>().getMedications(
        forceGetData: true,
        showState: false,
      );
    }
  }

  static Future<void> setTopics(String codeLang) async {
    final id = AppLocalData.user?.id ?? 0;
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      if (codeLang == AppConstant.en) {
        await FirebaseMessaging.instance.subscribeToTopic('en-$id');
        await FirebaseMessaging.instance.subscribeToTopic('en-all-users');
        await FirebaseMessaging.instance.unsubscribeFromTopic('ar-$id');
        await FirebaseMessaging.instance.unsubscribeFromTopic('ar-all-users');
      } else {
        await FirebaseMessaging.instance.subscribeToTopic('ar-$id');
        await FirebaseMessaging.instance.subscribeToTopic('ar-all-users');
        await FirebaseMessaging.instance.unsubscribeFromTopic('en-$id');
        await FirebaseMessaging.instance.unsubscribeFromTopic('en-all-users');
      }
    } catch (e) {
      printme.red(e);
    }
  }

  // when logout
  static Future<void> deleteTopics() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
    } catch (e) {
      printme.red(e);
    }
  }
}
