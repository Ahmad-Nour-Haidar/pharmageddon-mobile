import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
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
    _requestPermissionNotification();
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

  Future<void> setTopics(String codeLang) async {
    final id = AppLocalData.user?.id ?? 0;
    try {
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
  Future<void> deleteTopics() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
    } catch (e) {
      printme.red(e);
    }
  }
}
