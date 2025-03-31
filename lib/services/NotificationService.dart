import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationService{
  Future<void> initialize();
  Future<void> showNotification(RemoteMessage message);
}