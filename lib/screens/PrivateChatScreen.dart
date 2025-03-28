import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/app/AppColors.dart';
import 'package:training_app/components/AppFormField.dart';
import 'package:training_app/components/MessageBubble.dart';
import 'package:training_app/controllers/PrivateChatController.dart';
import 'package:training_app/models/ChatCardModel.dart';
import 'package:training_app/models/ChatModel.dart';
import 'package:training_app/models/MessageModel.dart';
import 'package:training_app/utils/DateFormatter.dart';
import 'package:training_app/validators/FormValidator.dart';

class PrivateChatScreen extends StatefulWidget {
  final ChatModel chat;
  const PrivateChatScreen({super.key, required this.chat});

  @override
  State<PrivateChatScreen> createState() => _PrivateChatScreenState();
}

class _PrivateChatScreenState extends State<PrivateChatScreen>
    with FormValidator {
  late final PrivateChatController _controller;
  Stream<QuerySnapshot>? _messageStream;
  Stream<DocumentSnapshot>? _isTypingStream;

  @override
  void initState() {
    _controller = context.read<PrivateChatController>();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {
          _messageStream = _controller.loadMessages(chat: widget.chat);
          _isTypingStream = _controller.contactIsTyping(chatData: widget.chat);
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.contact.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: _messageStream == null
                  ? const SizedBox.shrink()
                  : StreamBuilder(
                      stream: _messageStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(
                              'Send your first message!',
                              style: TextStyle(
                                  color: AppColors.hintColor,
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic),
                            ),
                          );
                        }

                        List<MessageModel> messages = snapshot.data!.docs
                            .map((e) => MessageModel.fromDoc(doc: e))
                            .toList();

                        Future.microtask(
                          () =>
                              _controller.onNewMessage(message: messages.last),
                        );

                        return ListView.separated(
                          controller: _controller.messageScrollController,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            final isContactMessage =
                                message.userId == widget.chat.contact.id;
                            return Row(
                              mainAxisAlignment: isContactMessage
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: MessageBubble(
                                    onLongPressStart: (details) =>
                                        _controller.onMessageLongPress(
                                      context: context,
                                      chat: widget.chat,
                                      message: message,
                                      details: details,
                                    ),
                                    message: message.text,
                                    isContactMessage: isContactMessage,
                                    date: DateFormatter.formatTimestamp(
                                      message.timestamp,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      StreamBuilder(
                        stream: _isTypingStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox();
                          }
                          if (!snapshot.hasData || !snapshot.data!.exists) {
                            return const SizedBox();
                          }

                          final chat = ChatCardModel.fromDoc(
                            doc: snapshot.data!,
                          );
                          final isTyping = chat.usersTyping.contains(
                            widget.chat.contact.id,
                          );

                          return _isTypingStream == null
                              ? const SizedBox.shrink()
                              : isTyping
                                  ? Column(
                                      children: [
                                        Text(
                                          '${widget.chat.contact.name} is typing...',
                                          style: const TextStyle(
                                            color: AppColors.hintColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    )
                                  : const SizedBox();
                        },
                      )
                    ],
                  ),
                  Form(
                    key: _controller.messageFieldKey,
                    child: AppFormField(
                      onChanged: (p0) => _controller.messageOnChanged(
                        chatData: widget.chat,
                      ),
                      maxLines: null,
                      validator: isNotEmpty,
                      controller: _controller.messageController,
                      hintText: 'Message',
                      suffixIcon: IconButton(
                        onPressed: () => _controller.sendMessage(
                          chatData: widget.chat,
                        ),
                        icon: const Icon(Icons.send_rounded),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
