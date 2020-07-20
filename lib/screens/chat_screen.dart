import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chat/sKErH97DxKZO8uiBXxQd/messages')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final document = snapshot.data.documents;
          return ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(8),
                child: Text(document[index]['text']),
              );
            },
            itemCount: document.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chat/sKErH97DxKZO8uiBXxQd/messages')
              .add({'text' : 'Hii Herlian Here'});
        },
      ),
    );
  }
}
