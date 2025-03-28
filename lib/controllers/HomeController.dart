import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talkio/models/ChatCardModel.dart';
import 'package:talkio/models/ChatModel.dart';
import 'package:talkio/models/UserModel.dart';

abstract class HomeController {
  String get uuid;
  String get email;
  TextEditingController get searchBarController;
  TextEditingController get addContactName;
  TextEditingController get addContactEmail;
  GlobalKey<FormState> get formKey;

  void searchBarOnChanged(String text);
  void searchBarOnSubmitted(String text);
  Future<void> removeContact({required String contactEmail});
  Future<void> onChatCardTap({required ChatModel chatData});
  void cancelRemoveContact();
  Future<void> onContactCardTap({required UserModel contact});
  Future<void> sendAddContactForm();
  Future<void> quitPressed();

  Stream<QuerySnapshot> loadChats();
  Stream<QuerySnapshot> loadContacts();
  Future<UserModel> getContact({required String contactId});

  Stream<List<UserModel>> loadContactsByChats(List<ChatCardModel> chats, String currentUserId);
}
