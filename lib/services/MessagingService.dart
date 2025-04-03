import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:talkio/Global.dart';
import 'package:talkio/errors/TokenNotFoundException.dart';
import 'package:talkio/services/impl/NotificationServiceImpl.dart';

abstract class MessagingService {
  static Future<void> initialize() async {
    await FirebaseMessaging.instance.requestPermission(); // FOR IOS

    final _getToken = await FirebaseMessaging.instance.getToken();
    if (_getToken == null) {
      throw TokenNotFoundException();
    }

    tokenFCM = _getToken;

    FirebaseMessaging.onMessage.listen((message) {
      NotificationServiceImpl.instance.showNotification(message);
    });

    //FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //  notificationService.showNotification(message);
    //});

    FirebaseMessaging.onBackgroundMessage(_onBackgrondMessage);
  }
}

Future<void> _onBackgrondMessage(RemoteMessage message) async {
  NotificationServiceImpl.instance.showNotification(message);
}
