import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: SafeArea(
        child: const Center(
          child: Text('Chat Page', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}