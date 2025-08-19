import 'package:flutter/material.dart';
import 'package:kora_app/views/colors.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../model/message_model.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.isMe,
    required this.isImage,
    required this.message,
  });

  final bool isMe;
  final bool isImage;
  final Message message;

  @override
  Widget build(BuildContext context) => Align(
        alignment:
            isMe ? Alignment.topLeft : Alignment.topRight,
        child: Container(
          decoration: BoxDecoration(
            color: isMe ? darkpurple : Colors.white,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
            border: Border.all(color: darkpurple)
          ),
          margin: const EdgeInsets.only(
              top: 10, right: 10, left: 10),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: isMe
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              isImage
                  ? Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10),
                        image: DecorationImage(
                          image:
                              NetworkImage(message.content),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Text(message.content,
                      style: TextStyle(
                        color: isMe ? Colors.white : darkgray,)),
              const SizedBox(height: 5),
              Text(
                timeago.format(message.sentTime),
                style: TextStyle(
                  color: isMe ? Colors.white : darkgray,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      );
}
