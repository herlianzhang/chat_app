import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final chatDocs = snapshot.data.documents;
        return ListView.builder(
          reverse: true,
          itemBuilder: (context, index) {
            return Text(chatDocs[index]['text']); // start here.
          },
          itemCount: chatDocs.length,
        );
      },
    );
  }
}
