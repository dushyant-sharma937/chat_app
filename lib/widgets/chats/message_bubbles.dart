import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String username;
  const MessageBubble(
      {super.key,
      required this.message,
      required this.isMe,
      required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: isMe
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onSecondaryContainer,
            borderRadius: BorderRadius.only(
              bottomLeft:
                  !isMe ? const Radius.circular(18) : const Radius.circular(12),
              bottomRight:
                  isMe ? const Radius.circular(18) : const Radius.circular(12),
              topLeft:
                  !isMe ? const Radius.circular(0) : const Radius.circular(18),
              topRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(18),
            ),
          ),
          // width: size.width * 0.3,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          margin: EdgeInsets.only(
            top: 4,
            bottom: 4,
            right: isMe ? 8 : 18,
            left: !isMe ? 8 : 18,
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMe)
                Text(
                  '~ $username',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                  // textAlign: TextAlign.start,
                ),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
