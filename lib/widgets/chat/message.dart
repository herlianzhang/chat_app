import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, futureSnapshot) => StreamBuilder(
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
            itemBuilder: (context, index) => MessageBubble(
              chatDocs[index]['text'],
              chatDocs[index]['username'],
              chatDocs[index]['image_url'],
              chatDocs[index]['userId'] == futureSnapshot.data.uid,
              key: ValueKey(chatDocs[index].documentID),
            ),
            itemCount: chatDocs.length,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(
      onMessage: (message) {
        print('from onMessage: $message');
        return;
      },
      onResume: (message) {
        print('from onResume: $message');
        return;
      },
      onLaunch: (message) {
        print('from onLaunch: $message');
        return;
      },
    );
    fbm.subscribeToTopic('chat');
  }
}
