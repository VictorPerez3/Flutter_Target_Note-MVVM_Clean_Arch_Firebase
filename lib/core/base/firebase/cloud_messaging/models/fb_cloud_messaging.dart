import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project_target/core/base/firebase/cloud_messaging/fb_cloud_messaging_provider.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

class FbCloudMessagingImpl implements FbCloudMessagingProvider {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final _messageStreamController = BehaviorSubject<RemoteMessage>();

  @override
  Future<void> backgroundHandler(RemoteMessage message) async {
    if (kDebugMode) {
      Logger().i("Handling a background message: ${message.messageId}");
      Logger().i('Message data: ${message.data}');
      Logger().i('Message notification: ${message.notification?.title}');
      Logger().i('Message notification: ${message.notification?.body}');
    }
  }

  @override
  Future<void> requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      Logger().i('User granted permission: ${settings.authorizationStatus}');
    }
  }

  @override
  void onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        Logger().i('Handling a foreground message: ${message.messageId}');
        Logger().i('Message data: ${message.data}');
        Logger().i('Message notification: ${message.notification?.title}');
        Logger().i('Message notification: ${message.notification?.body}');
      }
      _messageStreamController.sink.add(message);
    });
  }

  @override
  void onBackgroundMessage() {
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  @override
  Future<void> getToken() async {
    final token = await _messaging.getToken();
    if (kDebugMode) {
      Logger().i('Registration Token=$token');
    }
  }

  @override
  void onMainApplication() async {
    requestPermission();
    getToken();
    onMessage();
    onBackgroundMessage();
  }

}
