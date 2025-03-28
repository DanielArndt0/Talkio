import 'package:training_app/errors/AuthException.dart';

class UserLogouException extends AuthException {
  UserLogouException({
    super.message = 'The user has been logged out.',
    super.code = 'user-logout',
  });
}
