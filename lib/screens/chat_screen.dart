import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chats/messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Chat App',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          actions: [
            DropdownButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'logout',
                    child: Row(children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text("Logout"),
                    ]),
                  )
                ],
                onChanged: (itemIdentifier) {
                  if (itemIdentifier == 'logout') {
                    FirebaseAuth.instance.signOut();
                  }
                })
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        body: Container(
          child: const Column(
            children: [
              Expanded(child: Messages()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection("chats/lDj9jdw2OTddt2xl0LiD/messages")
                .add({'text': 'This was added by clicking the button!'});
          },
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
