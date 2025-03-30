import 'package:talkio/services/NotificationService.dart';
import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServiceImpl implements NotificationService {
  static final instance = NotificationServiceImpl._();
  NotificationServiceImpl._();

  final _notificationPlugin = FlutterLocalNotificationsPlugin();

  @override
  Future<void> initialize() async {
    final androidInitSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    final iosInitSettings = DarwinInitializationSettings();

    final initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    final isPermAcceptedAndroid =
        await _notificationPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission();

    final isPermAcceptedIos = await _notificationPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    if (isPermAcceptedAndroid ?? false) {
      print('Permissão aceita android');
    } else {
      print('Permissão negada android');
    }

    if (isPermAcceptedIos ?? false) {
      print('Permissão aceita Ios');
    } else {
      print('Permissão negada Ios');
    }

    await _notificationPlugin.initialize(initSettings);
  }

  @override
  Future<void> showNotification(RemoteMessage message) async {
    final androidDetails = AndroidNotificationDetails(
      message.notification?.android?.channelId ?? 'CH_NOTF_ID',
      "HIGH_PRIORITY_NOTF",
      priority: Priority.max,
      importance: Importance.max,
    );

    final iosDetais = DarwinNotificationDetails(
      sound: message.notification?.apple?.sound?.name,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetais,
    );

    _notificationPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }
}
