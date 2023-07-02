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
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe
                ? const Color.fromARGB(200, 145, 144, 144)
                : Color.fromARGB(211, 19, 19, 89),
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
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isMe ? Colors.black : Colors.green.shade300,
                  ),
                  // textAlign: TextAlign.start,
                ),
              Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
