import 'package:training_app/errors/AuthException.dart';

class UserDisabledException extends AuthException {
  UserDisabledException({
    super.message = 'The user corresponding to the email address provided has been disabled.',
    super.code = 'user-disabled',
  });
}
