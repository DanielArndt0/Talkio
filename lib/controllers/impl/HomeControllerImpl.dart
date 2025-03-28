import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:training_app/controllers/HomeController.dart';
import 'package:training_app/controllers/NavigationController.dart';
import 'package:training_app/errors/CloudException.dart';
import 'package:training_app/models/ChatCardModel.dart';
import 'package:training_app/models/ChatModel.dart';
import 'package:training_app/models/UserModel.dart';
import 'package:training_app/services/AuthService.dart';
import 'package:training_app/services/CloudDBService.dart';

class HomeControllerImpl implements HomeController {
  final TextEditingController _searchBarController = TextEditingController();
  final TextEditingController _addContactEmail = TextEditingController();
  final TextEditingController _addContactName = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  HomeControllerImpl({
    required this.authService,
    required this.cloudDbService,
    required this.navigationController,
  });

  late final AuthService authService;
  late final CloudDBService cloudDbService;
  late final NavigationController navigationController;

  @override
  TextEditingController get searchBarController => _searchBarController;

  @override
  TextEditingController get addContactEmail => _addContactEmail;

  @override
  TextEditingController get addContactName => _addContactName;

  @override
  GlobalKey<FormState> get formKey => _formKey;

  @override
  String get uuid {
    return authService.currentUser.uid;
  }

  @override
  String get email {
    return authService.currentUser.email!;
  }

  @override
  void searchBarOnChanged(String text) {}

  @override
  void searchBarOnSubmitted(String text) {}

  @override
  Future<void> quitPressed() async {
    await authService.signOut();
  }

  @override
  Future<void> sendAddContactForm() async {
    try {
      if (formKey.currentState!.validate()) {
        await cloudDbService.addContactByEmail(
          email: addContactEmail.text,
          name: addContactName.text,
          userID: authService.currentUser.uid,
        );
        navigationController.showSnackbar(
            message:
                '${addContactName.text} has been added to your contact list!');
      }
    } on CloudException catch (error) {
      navigationController.showSnackbar(message: error.message);
    } catch (error) {
      navigationController.showSnackbar(message: error.toString());
    } finally {
      if (formKey.currentState!.validate()) {
        addContactEmail.text = '';
        addContactName.text = '';
      }
    }
  }

  @override
  void cancelRemoveContact() {
    navigationController.pop();
  }

  @override
  Future<void> removeContact({required String contactEmail}) async {
    try {
      await cloudDbService.deleteContact(
        userID: authService.currentUser.uid,
        contactEmail: contactEmail,
      );
    } on CloudException catch (error) {
      navigationController.showSnackbar(message: error.message);
    } catch (error) {
      navigationController.showSnackbar(message: error.toString());
    } finally {
      navigationController.pop();
    }
  }

  @override
  Future<void> onChatCardTap({required ChatModel chatData}) async {
    await navigationController.goToChat(chatData: chatData);
  }

  @override
  Stream<QuerySnapshot> loadChats() {
    return cloudDbService.getChats(userId: authService.currentUser.uid);
  }

  @override
  Stream<QuerySnapshot> loadContacts() {
    return cloudDbService.getContacts(userID: authService.currentUser.uid);
  }

  @override
  Future<UserModel> getContact({required String contactId}) async {
    try {
      final contact = await cloudDbService.getContactById(
          userId: authService.currentUser.uid, contactId: contactId);
      return UserModel(
        id: contactId,
        name: contact.name,
        email: contact.name,
      );
    } catch (error) {
      final contactUser = await cloudDbService.getUserById(userId: contactId);
      return UserModel(
        id: contactId,
        name: contactUser.name,
        email: contactUser.name,
      );
    }
  }

  @override
  Future<void> onContactCardTap({required UserModel contact}) async {
    try {
      await cloudDbService.createChat(
        userId: authService.currentUser.uid,
        contactId: contact.id,
      );
    } on CloudException catch (error) {
      navigationController.showSnackbar(message: error.message);
    } catch (error) {
      navigationController.showSnackbar(message: error.toString());
    } finally {
      navigationController.pop();
    }
  }

  @override
  Stream<List<UserModel>> loadContactsByChats(List<ChatCardModel> chats, String currentUserId) {
    return cloudDbService.loadContactsByChats(chats, currentUserId);
  }
}
