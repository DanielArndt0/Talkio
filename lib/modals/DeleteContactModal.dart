import 'package:flutter/material.dart';
import 'package:training_app/app/AppColors.dart';
import 'package:training_app/controllers/HomeController.dart';

class DeleteContactModal extends StatelessWidget {
  final HomeController controller;
  final String contactEmail;
  const DeleteContactModal({
    super.key,
    required this.controller,
    required this.contactEmail,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceBetween,
      title: const Text(
        'Do you want to remove this contact?',
      ),
      actions: [
        ElevatedButton(
          onPressed: () => controller.removeContact(contactEmail: contactEmail),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryMaterialColor,
          ),
          child: const Text(
            'Remove',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: controller.cancelRemoveContact,
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
