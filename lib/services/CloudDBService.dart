import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talkio/models/ChatCardModel.dart';
import 'package:talkio/models/UserModel.dart';

abstract class CloudDBService {
  Future<void> createUser({
    required String name,
    required String userID,
    required String email,
  });

  Future<void> addContact({
    required String name,
    required String email,
    required String contactId,
    required String userID,
  });

  Future<void> addContactByEmail({
    required String name,
    required String email,
    required String userID,
  });

  Future<void> deleteContact({
    required String userID,
    required String contactEmail,
  });

  Future<String?> getUserIdByEmail(String email);

  Future<bool> contactAlreadyExists({
    required String userId,
    required String contactEmail,
  });

  Stream<QuerySnapshot> getContacts({required String userID});

  Future<void> createChat({
    required String userId,
    required String contactId,
  });

  Future<String?> getChatIdByUsersId({
    required String userId,
    required String contactId,
  });

  Future<void> sendMessage(
      {required String userId,
      required String contactId,
      required String text});

  Stream<QuerySnapshot> getMessages({required String chatId});

  Stream<QuerySnapshot> getChats({required String userId});

  Future<UserModel> getUserById({required String userId});

  Future<UserModel> getContactById({
    required String userId,
    required String contactId,
  });

  Stream<List<UserModel>> loadContactsByChats(
    List<ChatCardModel> chats,
    String currentUserId,
  );

  Future<void> deleteChat({required String chatId});

  Future<void> deleteMessage({
    required String userId,
    required String chatId,
    required String messageId,
  });

  Future<void> deleteUserFromChat({
    required String chatId,
    required String userId,
  });

  Future<void> setTyping({
    required String chatId,
    required String userId,
    required bool isTyping,
  });

  Stream<DocumentSnapshot<Object?>> getChatStream({required String chatId});
}
