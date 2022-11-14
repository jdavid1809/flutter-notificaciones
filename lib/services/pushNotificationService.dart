//E4:59:35:F7:80:84:AC:4D:17:2A:05:CB:76:B7:3B:EA:30:DF:E8:A8

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStreamController =
      new StreamController();
  static Stream<String> get messageStream => _messageStreamController.stream;

  static Future _backgorundHandler(RemoteMessage message) async {
    // print('onBackground Handler: ${message.messageId}');
    _messageStreamController.add(message.data['product'] ?? 'No data');
    print(message.data);
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // print('onMessage Handler: ${message.messageId}');
    _messageStreamController.add(message.data['product'] ?? 'No data');
    print(message.data);
  }

  static Future _onMessageOpenHandler(RemoteMessage message) async {
    // print('onMessageOpen Handler: ${message.messageId}');
    _messageStreamController.add(message.data['product'] ?? 'No data');
    print(message.data);
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

  static closeStream() {
    _messageStreamController.close();
  }
}
