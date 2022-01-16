//packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _inputText = '';
  final _controller = TextEditingController();

  void _savedText() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final username = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chats').add(
      {
        'text': _inputText,
        'createAt': Timestamp.now(),
        'userId': user.uid,
        'username': username['username'],
        'imageurl':username['imageurl']
      },
    );
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(labelText: 'Send Message ...'),
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  _inputText = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _inputText.trim().isEmpty ? null : _savedText,
            icon: const Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
