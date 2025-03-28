import 'package:training_app/errors/CloudException.dart';

class ErrorCreatingChatException extends CloudException {
  ErrorCreatingChatException({
    super.message = 'Error while creating chat.',
    super.code = 'error-creating-chat',
  });
}
