import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// 로그인 하고나서 보여줄 화면

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          IconButton(
              onPressed: () {
                // 로그아웃을 구현할 것이다
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      body: const Center(
        child: Text('Logged in!'),
      ),
    );
  }
}
