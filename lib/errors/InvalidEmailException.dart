import 'package:talkio/errors/AuthException.dart';

class InvalidEmailException extends AuthException {
  InvalidEmailException({
    super.message = 'Email address is not valid.',
    super.code = 'invalid-email',
  });
}
