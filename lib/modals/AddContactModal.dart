import 'package:flutter/material.dart';
import 'package:talkio/app/AppColors.dart';
import 'package:talkio/components/AppFormField.dart';
import 'package:talkio/components/ChatCard.dart';
import 'package:talkio/components/TalkioLogo.dart';
import 'package:talkio/controllers/HomeController.dart';
import 'package:talkio/modals/DeleteContactModal.dart';
import 'package:talkio/models/UserModel.dart';

class AddContactModal extends StatelessWidget {
  final HomeController controller;
  final String? Function(String?)? validator;
  const AddContactModal({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 28),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: controller.cancelRemoveContact,
                ),
              ],
            ),
            const TalkioLogo(size: 40),
            const SizedBox(height: 18),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add your friends!',
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.fontColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            AppFormField(
              labelText: 'Enter your contact name',
              hintText: 'John Marston',
              controller: controller.addContactName,
              keyboardType: TextInputType.name,
              validator: validator,
            ),
            const SizedBox(height: 18),
            AppFormField(
              suffixIcon: GestureDetector(
                onTap: controller.sendAddContactForm,
                child: const Icon(Icons.send_rounded),
              ),
              labelText: 'Enter your contact e-mail',
              hintText: 'example@email.com',
              controller: controller.addContactEmail,
              keyboardType: TextInputType.emailAddress,
              validator: validator,
            ),
            const SizedBox(height: 18),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Contacts',
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.fontColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Expanded(
              child: StreamBuilder(
                stream: controller.loadContacts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Opacity(
                      opacity: 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            child: Image.asset(
                                'assets/images/contact-book.png',
                                height: 100,
                                width: 100),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Add your first contact',
                            softWrap: true,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: AppColors.hintColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  final contacts = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = UserModel.fromDoc(doc: contacts[index]);
                      return ChatCard(
                        onTap: () =>
                            controller.onContactCardTap(contact: contact),
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) => DeleteContactModal(
                              controller: controller,
                              contactEmail: contact.email,
                            ),
                          );
                        },
                        name: contact.name,
                        uuid: contact.id,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
