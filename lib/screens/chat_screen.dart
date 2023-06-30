import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat App',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chats/lDj9jdw2OTddt2xl0LiD/messages")
            .snapshots(),
        builder: (context, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data!.docs;
          return ListView.builder(
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                documents[index]['text'],
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            itemCount: documents.length,
          );
        },
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
    );
  }
}
