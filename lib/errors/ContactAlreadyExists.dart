import 'package:training_app/errors/CloudException.dart';

class ContactAlreadyExists extends CloudException {
  ContactAlreadyExists({
    super.message = 'Contact already exists.',
    super.code = 'contact-already-exists',
  });
}
