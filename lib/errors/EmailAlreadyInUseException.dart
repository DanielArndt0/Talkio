import 'package:training_app/errors/AuthException.dart';

class EmailAlreadyInUseException extends AuthException {
  EmailAlreadyInUseException({
    super.message = 'Already exists an account with the given email address.',
    super.code = 'email-already-in-use',
  });
}
