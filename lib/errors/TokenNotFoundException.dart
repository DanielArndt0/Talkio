import 'package:talkio/errors/MessagingException.dart';

class TokenNotFoundException extends MessagingException {
  TokenNotFoundException({
    super.message = 'FCM token not available.',
    super.code = 'fcm-not-available',
  });
}
