import 'package:talkio/errors/AuthException.dart';

class WeakPasswordException extends AuthException {
  WeakPasswordException({
    super.message = 'The password is not strong enough.',
    super.code = 'weak-password',
  });
}
