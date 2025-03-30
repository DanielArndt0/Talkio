import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:talkio/services/MessagingService.dart';
import 'package:talkio/services/NotificationService.dart';
import 'package:talkio/services/impl/NotificationServiceImpl.dart';

class MessagingServiceImpl implements MessagingService {
  MessagingServiceImpl({required this.notificationService});

  final _messaging = FirebaseMessaging.instance;
  final NotificationService notificationService;

  String? _token;

  @override
  Future<void> initialize() async {
    await _messaging.requestPermission(); // FOR IOS

    _token = await _messaging.getToken();

    FirebaseMessaging.onMessage.listen((message) {
      notificationService.showNotification(message);
    });

    //FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //  notificationService.showNotification(message);
    //});

    FirebaseMessaging.onBackgroundMessage(_onBackgrondMessage);
  }

  @override
  String get token => _token ?? '';
}

Future<void> _onBackgrondMessage(RemoteMessage message) async {
  NotificationServiceImpl.instance.showNotification(message);
}
