import 'dart:html';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.isMe, this.username, this.imageUrl);
  final String message;
  final bool isMe;
  final String username;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          width: 150,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: isMe
                ? Theme.of(context).colorScheme.secondaryContainer
                : Colors.grey,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 5.0,
                  offset: Offset.zero,
                  blurStyle: BlurStyle.normal,
                  color: Colors.grey),
            ],
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(17),
              topRight: const Radius.circular(17),
              bottomRight: isMe ? Radius.zero : const Radius.circular(17),
              bottomLeft: !isMe ? Radius.zero : const Radius.circular(17),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                message,
                style: TextStyle(color: isMe ? Colors.white : Colors.black),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 20,
          // backgroundImage: NetworkImage(imageUrl),
        ),
      ],
    );
  }
}
