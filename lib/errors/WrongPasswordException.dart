import 'package:talkio/errors/AuthException.dart';

class WrongPasswordException extends AuthException {
  WrongPasswordException({
    super.message = 'Invalid password or email address.',
    super.code = 'wrong-password',
  });
}
