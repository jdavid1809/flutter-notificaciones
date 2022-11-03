//E4:59:35:F7:80:84:AC:4D:17:2A:05:CB:76:B7:3B:EA:30:DF:E8:A8

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static Future _backgorundHandler(RemoteMessage message) async {
    print('onBackground Handler: ${message.messageId}');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print('onMessage Handler: ${message.messageId}');
  }

  static Future _onMessageOpenHandler(RemoteMessage message) async {
    print('onMessageOpen Handler: ${message.messageId}');
  }

  static Future initializeApp() async {
    //PushNotification
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('TOKEN: $token');

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgorundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenHandler);

    //Local notification
  }
}
