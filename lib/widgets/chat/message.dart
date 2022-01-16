//packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//files
import 'message_bubble.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('createAt', descending: true)
          .snapshots(),
      builder: (context, chatsnapshot) {
        if (chatsnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatsnapshot.data?.docs;
        final user = FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs?.length ?? 0,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.all(1.7),
            child: MessageBubble(
              chatDocs![index]['text'],
              chatDocs[index]['userId'] == user?.uid,
              chatDocs[index]['username'],
              chatDocs[index]['imageurl'],
            ),
          ),
        );
      },
    );
  }
}
