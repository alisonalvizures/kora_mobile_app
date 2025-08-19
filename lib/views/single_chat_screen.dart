import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/firebase_provider.dart';
import '../widget/chat_messages.dart';
import '../widget/chat_text_field.dart';
import 'colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.userId});

  final String userId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getUserById(widget.userId)
      ..getMessages(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
          children: [
            ChatMessages(receiverId: widget.userId),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Container(
              color: lavender,
              padding: EdgeInsets.all(16),
              child: ChatTextField(receiverId: widget.userId),
            ),

          ],
        ),
    );
  }

  AppBar _buildAppBar() => AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: lavender[500],
      titleTextStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 26, ),
      toolbarHeight: 80,
      elevation: 0,
      title: Consumer<FirebaseProvider>(
        builder: (context, value, child) =>
        value.user != null
            ? Row(
          children: [
            CircleAvatar(
              backgroundImage:
              NetworkImage(value.user!.image),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                Text(
                  value.user!.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value.user!.isOnline
                      ? 'Desconectado'
                      : 'En línea',
                  style: TextStyle(
                    color: value.user!.isOnline
                        ? Colors.white
                        : Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        )
            : const SizedBox(),
      ));
}
