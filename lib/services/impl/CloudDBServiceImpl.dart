import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:talkio/errors/CloudException.dart';
import 'package:talkio/errors/ContactAlreadyExists.dart';
import 'package:talkio/errors/ContactNotFound.dart';
import 'package:talkio/models/ChatCardModel.dart';
import 'package:talkio/models/UserModel.dart';
import 'package:talkio/services/CloudDBService.dart';

class CloudDBServiceImpl extends CloudDBService {
  CloudDBServiceImpl._();
  static final CloudDBServiceImpl instance = CloudDBServiceImpl._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createUser({
    required String name,
    required String userID,
    required String email,
    required String tokenFCM,
  }) async {
    try {
      await _firestore.collection('users').doc(userID).set({
        'name': name,
        'email': email,
        'tokensFCM': FieldValue.arrayUnion([tokenFCM]),
      });
    } on FirebaseException catch (error) {
      throw CloudException(
        message: error.message ?? 'Error to create user.',
        code: error.code,
      );
    }
  }

  @override
  Future<void> addContact({
    required String name,
    required String email,
    required String contactId,
    required String userID,
  }) async {
    try {
      final contactsRef = await _firestore
          .collection('users')
          .doc(userID)
          .collection('contacts')
          .doc(contactId);

      contactsRef.set({'name': name, 'email': email});
    } on FirebaseException catch (error) {
      throw CloudException(
        message: error.message ?? 'Error to add contact.',
        code: error.code,
      );
    }
  }

  @override
  Future<void> addContactByEmail({
    required String name,
    required String email,
    required String userID,
  }) async {
    final exists = await contactAlreadyExists(
      contactEmail: email,
      userId: userID,
    );
    if (exists) {
      throw ContactAlreadyExists();
    }

    final contactId = await getUserIdByEmail(email);
    if (contactId != null) {
      try {
        final contactsRef = await _firestore
            .collection('users')
            .doc(userID)
            .collection('contacts')
            .doc(contactId);

        contactsRef.set({'name': name, 'email': email});
      } on FirebaseException catch (error) {
        throw CloudException(
          message: error.message ?? 'Error to add contact.',
          code: error.code,
        );
      }
    } else {
      throw ContactNotFound();
    }
  }

  @override
  Future<String?> getUserIdByEmail(String email) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('users')
              .where('email', isEqualTo: email)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> contactAlreadyExists({
    required String userId,
    required String contactEmail,
  }) async {
    try {
      final query =
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('contacts')
              .where('email', isEqualTo: contactEmail)
              .limit(1)
              .get();

      return query.docs.isNotEmpty;
    } catch (error) {
      return false;
    }
  }

  @override
  Stream<QuerySnapshot> getContacts({required String userID}) {
    try {
      return _firestore
          .collection('users')
          .doc(userID)
          .collection('contacts')
          .snapshots();
    } on FirebaseException catch (error) {
      throw CloudException(
        message: error.message ?? 'Error to get contacts.',
        code: error.code,
      );
    }
  }

  @override
  Future<void> deleteContact({
    required String userID,
    required String contactEmail,
  }) async {
    final String? contactId = await getUserIdByEmail(contactEmail);
    if (contactId != null) {
      try {
        await _firestore
            .collection('users')
            .doc(userID)
            .collection('contacts')
            .doc(contactId)
            .delete();
      } on FirebaseException catch (error) {
        throw CloudException(
          message: error.message ?? 'Error to delete contact.',
          code: error.code,
        );
      }
    } else {
      throw ContactNotFound();
    }
  }

  @override
  Future<void> createChat({
    required String userId,
    required String contactId,
  }) async {
    try {
      final userChats =
          await _firestore
              .collection('chats')
              .where('users', arrayContains: userId)
              .get();

      final alreadyExists = userChats.docs.any((doc) {
        final users = List<String>.from(doc['users']);
        return users.toSet().containsAll({userId, contactId});
      });

      if (alreadyExists) {
        return;
      }

      await _firestore.collection('chats').add({
        'users': [userId, contactId],
        'usersTyping': [],
        'lastMessage': '',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (error) {
      throw CloudException(
        message: error.message ?? 'Error to create chat.',
        code: error.code,
      );
    }
  }

  @override
  Future<String?> getChatIdByUsersId({
    required String userId,
    required String contactId,
  }) async {
    final userChats =
        await _firestore
            .collection('chats')
            .where('users', arrayContains: userId)
            .get();

    for (final doc in userChats.docs) {
      final users = List<String>.from(doc['users']);

      final sameChat =
          users.toSet().containsAll({userId, contactId}) && users.length == 2;

      if (sameChat) {
        return doc.id;
      }
    }

    return null;
  }

  @override
  Future<void> sendMessage({
    required String userId,
    required String contactId,
    required String text,
  }) async {
    final chatId = await getChatIdByUsersId(
      userId: userId,
      contactId: contactId,
    );
    if (chatId != null) {
      final messagesRef = await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages');

      messagesRef.add({
        'userId': userId,
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      await _firestore.collection('chats').doc(chatId).update({
        'timestamp': FieldValue.serverTimestamp(),
        'lastMessage': text,
      });
    }
  }

  @override
  Stream<QuerySnapshot> getMessages({required String chatId}) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  @override
  Stream<QuerySnapshot> getChats({required String userId}) {
    return _firestore
        .collection('chats')
        .where('users', arrayContains: userId)
        .snapshots();
  }

  @override
  Future<UserModel> getUserById({required String userId}) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return UserModel.fromDoc(doc: doc);
  }

  @override
  Future<UserModel> getContactById({
    required String userId,
    required String contactId,
  }) async {
    final doc =
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('contacts')
            .doc(contactId)
            .get();
    return UserModel.fromDoc(doc: doc);
  }

  @override
  Future<void> deleteChat({required String chatId}) async {
    try {
      await _firestore.collection('chats').doc(chatId).delete();
    } on FirebaseException catch (error) {
      throw CloudException(
        message: error.message ?? 'Error to delete chat.',
        code: error.code,
      );
    }
  }

  @override
  Future<void> deleteMessage({
    required String userId,
    required String chatId,
    required String messageId,
  }) async {
    try {
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .delete();
    } on FirebaseException catch (error) {
      throw CloudException(
        message: error.message ?? 'Error to delete chat.',
        code: error.code,
      );
    }
  }

  @override
  Future<void> deleteUserFromChat({
    required String chatId,
    required String userId,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
        'users': FieldValue.arrayRemove([userId]),
      });
    } on FirebaseException catch (error) {
      throw CloudException(
        message: error.message ?? 'Error to delete user From chat.',
        code: error.code,
      );
    }
  }

  @override
  Future<void> setTyping({
    required String chatId,
    required String userId,
    required bool isTyping,
  }) async {
    final chatRef = _firestore.collection('chats').doc(chatId);

    await chatRef.update({
      'usersTyping':
          isTyping
              ? FieldValue.arrayUnion([userId])
              : FieldValue.arrayRemove([userId]),
    });
  }

  @override
  Stream<DocumentSnapshot> getChatStream({required String chatId}) {
    return _firestore.collection('chats').doc(chatId).snapshots();
  }

  @override
  Stream<List<UserModel>> loadContactsByChats(
    List<ChatCardModel> chats,
    String currentUserId,
  ) {
    final contactIds =
        chats.map((chat) => chat.getContactId(currentUserId)).toSet().toList();

    if (contactIds.isEmpty) {
      return Stream.value([]);
    }

    return _firestore
        .collection('users')
        .where(FieldPath.documentId, whereIn: contactIds)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => UserModel.fromDoc(doc: doc)).toList(),
        );
  }

  @override
  Future<void> updateTokenFCM({
    required String userId,
    required String token,
  }) async {
    await _firestore.collection('users').doc(userId).update({
      'tokensFCM': FieldValue.arrayUnion([token]),
    });
  }
}
