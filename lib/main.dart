import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pharmageddon_mobile/controllers/favorite_cubit/favorite_cubit.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_mobile/core/constant/app_size.dart';
import 'package:pharmageddon_mobile/print.dart';
import 'package:pharmageddon_mobile/routes.dart';
import 'controllers/local_controller.dart';
import 'controllers/order_cubit/order_cubit.dart';
import 'core/constant/app_constant.dart';
import 'core/localization/translation.dart';
import 'core/notifications/app_notifications_keys.dart';
import 'core/resources/theme_manager.dart';
import 'core/services/dependency_injection.dart';
import 'core/notifications/app_firebase.dart';
import 'firebase_options.dart';
import 'my_bloc_observer.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  AppFirebase.firebaseMessagingBackgroundHandler(message);
}

Future<void> _firebaseMessaging(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  AppFirebase.firebaseMessaging(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await AppInjection.initial();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  } catch (e) {
    printme.red(e);
  }
  FirebaseMessaging.onMessage.listen(_firebaseMessaging);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Bloc.observer = AppInjection.getIt<MyBlocObserver>();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: AppNKeys.groupKey,
        channelKey: AppNKeys.channelKey,
        channelName: AppNKeys.channelName,
        channelDescription: AppNKeys.channelDescription,
        importance: NotificationImportance.Max,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: AppNKeys.channelKey,
        channelGroupName: AppNKeys.groupName,
      ),
    ],
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  //
  // AwesomeNotifications().setListeners(
  //   onActionReceivedMethod: (ReceivedAction receivedAction) async {
  //     NotificationController.onActionReceivedMethod(receivedAction);
  //   },
  //   onNotificationCreatedMethod:
  //       (ReceivedNotification receivedNotification) async {
  //     NotificationController.onNotificationCreatedMethod(receivedNotification);
  //   },
  //   onNotificationDisplayedMethod:
  //       (ReceivedNotification receivedNotification) async {
  //     NotificationController.onNotificationDisplayedMethod(
  //         receivedNotification);
  //   },
  //   onDismissActionReceivedMethod: (ReceivedAction receivedAction) async {
  //     NotificationController.onDismissActionReceivedMethod(receivedAction);
  //   },
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.initial(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppInjection.getIt<HomeCubit>()..initial()),
        BlocProvider(create: (context) => AppInjection.getIt<FavoriteCubit>()),
        BlocProvider(create: (context) => AppInjection.getIt<OrderCubit>()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstant.isEnglish ? 'Pharmageddon' : 'فارماجيدون',
        locale: AppInjection.getIt<LocaleController>().locale,
        translations: MyTranslation(),
        theme: themeData(),
        routes: routes,
        initialRoute: AppRoute.splash,
      ),
    );
  }
}
