import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pharmageddon_mobile/controllers/favorite_cubit/favorite_cubit.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_mobile/controllers/notification_cubit/notification_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_local_data.dart';
import 'package:pharmageddon_mobile/core/constant/app_size.dart';
import 'package:pharmageddon_mobile/print.dart';
import 'package:pharmageddon_mobile/routes.dart';
import 'package:pharmageddon_mobile/view/widgets/handle_state.dart';
import 'controllers/local_controller.dart';
import 'controllers/notification_controller.dart';
import 'controllers/notification_cubit/notification_cubit.dart';
import 'controllers/order_cubit/order_cubit.dart';
import 'core/constant/app_constant.dart';
import 'core/localization/translation.dart';
import 'core/resources/theme_manager.dart';
import 'core/services/dependency_injection.dart';
import 'my_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  await AppInjection.initial();

  Bloc.observer = AppInjection.getIt<MyBlocObserver>();
  printme.red(AppLocalData.user?.id);

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        importance: NotificationImportance.Max,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic group',
      ),
    ],
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  AwesomeNotifications().setListeners(
    onActionReceivedMethod: (ReceivedAction receivedAction) async {
      NotificationController.onActionReceivedMethod(receivedAction);
    },
    onNotificationCreatedMethod:
        (ReceivedNotification receivedNotification) async {
      NotificationController.onNotificationCreatedMethod(receivedNotification);
    },
    onNotificationDisplayedMethod:
        (ReceivedNotification receivedNotification) async {
      NotificationController.onNotificationDisplayedMethod(
          receivedNotification);
    },
    onDismissActionReceivedMethod: (ReceivedAction receivedAction) async {
      NotificationController.onDismissActionReceivedMethod(receivedAction);
    },
  );

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
        BlocProvider(
          create: (context) => AppInjection.getIt<NotificationCubit>()..init(),
        ),
      ],
      child: BlocListener<NotificationCubit, NotificationState>(
        listener: (context, state) {
          if (state is NewNotification) {
            handleState(state: state.state, context: context);
          }
        },
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstant.isEnglish ? 'Pharmageddon' : 'فارماجيدون',
          locale: AppInjection.getIt<LocaleController>().locale,
          translations: MyTranslation(),
          theme: themeData(),
          routes: routes,
          initialRoute: AppRoute.splash,
        ),
      ),
    );
  }
}
