import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static Future init() async {
    await messaging.requestPermission(alert: true, badge: true, sound: true);

    token = await messaging.getToken();

    if (token != null) {
      log('FCM Token: $token');
    } else {
      log('Failed to get FCM Token');
    }
  }
}
