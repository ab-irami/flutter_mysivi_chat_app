import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysivi_chat_app/core/widgets/message_bubble.dart';

void main() {
  testWidgets('MessageBubble handles long text safely', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MessageBubble(
            sender: 'Alice',
            text: 'Long message ' * 20,
            isMe: false,
          ),
        ),
      ),
    );

    expect(find.byType(MessageBubble), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
  });
}
