import 'package:talkio/errors/AuthException.dart';

class OperationNotAllowedException extends AuthException {
  OperationNotAllowedException({
    super.message = 'Operation not allowed.',
    super.code = 'operation-not-allowed',
  });
}
