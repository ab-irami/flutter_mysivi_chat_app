import 'package:flutter/material.dart';

class ChatHistoryTab extends StatelessWidget {
  const ChatHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Chat History Tab',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
