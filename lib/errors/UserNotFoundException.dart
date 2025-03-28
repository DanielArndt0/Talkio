import 'package:training_app/errors/AuthException.dart';

class UserNotFoundException extends AuthException {
  UserNotFoundException({
    super.message = 'No user corresponding to the email address provided.',
    super.code = 'user-not-found',
  });
}
