import 'package:training_app/errors/CloudException.dart';

class ChatNotFound extends CloudException {
  ChatNotFound(
      {super.message = 'Chat not founded.', super.code = 'chat-not-found'});
}
