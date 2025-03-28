import 'package:talkio/errors/CloudException.dart';

class ContactNotFound extends CloudException {
  ContactNotFound({
    super.message = 'Contact not found.',
    super.code = 'contact-not-found',
  });
}
