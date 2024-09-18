import 'package:firebase_messaging/firebase_messaging.dart';

abstract class FbCloudMessagingProvider {
  Future<void> backgroundHandler(RemoteMessage message);

  Future<void> requestPermission();

  void onMessage();

  void onBackgroundMessage();

  Future<void> getToken();

  void onMainApplication();
}
