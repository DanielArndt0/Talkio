import 'package:talkio/errors/AuthException.dart';

class UserNotFoundException extends AuthException {
  UserNotFoundException({
    super.message = 'No user corresponding to the email address provided.',
    super.code = 'user-not-found',
  });
}
