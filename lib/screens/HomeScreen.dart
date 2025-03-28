import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talkio/app/AppColors.dart';
import 'package:talkio/components/Avatar.dart';
import 'package:talkio/components/ChatCard.dart';
import 'package:talkio/controllers/HomeController.dart';
import 'package:talkio/modals/AddContactModal.dart';
import 'package:talkio/models/ChatCardModel.dart';
import 'package:talkio/models/ChatModel.dart';
import 'package:talkio/models/UserModel.dart';
import 'package:talkio/utils/DateFormatter.dart';
import 'package:talkio/validators/FormValidator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with FormValidator {
  late final HomeController _controller;
  Stream<QuerySnapshot<Object?>>? _loadChats;

  @override
  void initState() {
    _controller = context.read<HomeController>();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {
          _loadChats = _controller.loadChats();
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: _controller.quitPressed,
              child: const Icon(
                Icons.exit_to_app_rounded,
              ),
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Avatar(uuid: _controller.uuid),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 18),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBar(
                controller: _controller.searchBarController,
                onChanged: (value) {
                  _controller.searchBarOnChanged(value);
                  setState(() {});
                },
                onSubmitted: _controller.searchBarOnSubmitted,
                leading: const Icon(Icons.search, color: AppColors.hintColor),
                hintStyle: const WidgetStatePropertyAll(
                  TextStyle(
                    color: AppColors.hintColor,
                  ),
                ),
                shape: const WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                hintText: 'Search by last message',
                backgroundColor: const WidgetStatePropertyAll(
                  AppColors.searchBarColor,
                ),
                elevation: const WidgetStatePropertyAll(0),
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder(
              stream: _loadChats,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final chats = snapshot.data!.docs
                    .map((doc) => ChatCardModel.fromDoc(doc: doc))
                    .toList();

                if (chats.isEmpty) {
                  return const Text(
                    'No chats found.',
                    style: TextStyle(
                      color: AppColors.hintColor,
                      fontStyle: FontStyle.italic,
                    ),
                  );
                }

                return _loadChats == null
                    ? const SizedBox.shrink()
                    : StreamBuilder<List<UserModel>>(
                        stream: _controller.loadContactsByChats(
                          chats,
                          _controller.uuid,
                        ),
                        builder: (context, contactSnapshot) {
                          if (!contactSnapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          final contacts = contactSnapshot.data!;
                          final filteredChats = chats.where(
                            (chat) {
                              return chat.lastMessage.toLowerCase().contains(
                                  _controller.searchBarController.text
                                      .toLowerCase());
                            },
                          ).toList();

                          return Expanded(
                            child: ListView.builder(
                              itemCount: filteredChats.length,
                              itemBuilder: (context, index) {
                                final chat = filteredChats[index];
                                final contactId =
                                    chat.getContactId(_controller.uuid);

                                final contact = contacts.firstWhere(
                                  (c) => c.id == contactId,
                                  orElse: () => UserModel.empty(),
                                );

                                final lastMessage =
                                    chat.usersTyping.contains(contact.id)
                                        ? 'Typing...'
                                        : chat.lastMessage;

                                return ChatCard(
                                  onTap: () => _controller.onChatCardTap(
                                    chatData: ChatModel(
                                      chatData: chat,
                                      contact: contact,
                                    ),
                                  ),
                                  uuid: contact.id,
                                  name: contact.name,
                                  date: DateFormatter.formatTimestamp(
                                    chat.timestamp?.toUtc(),
                                  ),
                                  lastMessage: lastMessage,
                                );
                              },
                            ),
                          );
                        },
                      );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryMaterialColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_comment_rounded, color: Colors.white),
        onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => AddContactModal(
            controller: _controller,
            validator: isNotEmpty,
          ),
        ),
      ),
    );
  }
}
