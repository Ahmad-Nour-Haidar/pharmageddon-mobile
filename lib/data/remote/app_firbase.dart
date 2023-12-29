import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pharmageddon_mobile/controllers/local_controller.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/print.dart';

import '../../core/constant/app_local_data.dart';
import '../../firebase_options.dart';

class AppFirebase {
  AppFirebase._();

  static Future<AppFirebase> getInstance() async {
    final appFirebase = AppFirebase._();
    await appFirebase._init();
    return appFirebase;
  }

  Future<void> _init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await _requestPermissionNotification();
    await setTopics();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      printme.blue(message.data);
    });
  }

  Future<void> _requestPermissionNotification() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> setTopics() async {
    final id = AppLocalData.user?.id.toString() ?? '0';
    final codeLang = AppInjection.getIt<LocaleController>().locale.languageCode;
    final oneTopic = '$codeLang-$id';
    final allTopics = '$codeLang-all-users';
    try {
      await FirebaseMessaging.instance.deleteToken();
      await FirebaseMessaging.instance.subscribeToTopic(oneTopic);
      await FirebaseMessaging.instance.subscribeToTopic(allTopics);
    } catch (e) {
      printme.red(e);
    }
  }

  Future<void> deleteTopics() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
    } catch (e) {
      printme.red(e);
    }
  }
}
