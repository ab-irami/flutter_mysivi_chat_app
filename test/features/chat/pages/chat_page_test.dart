import 'package:flutter_mysivi_chat_app/features/chat/views/chat_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mysivi_chat_app/features/chat/bloc/chat_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mock_helpers.dart';

void main() {
  testWidgets('ChatPage sends message', (tester) async {
    final mockServices = MockChatServices();

    when(
      () => mockServices.fetchRandomMessage(),
    ).thenAnswer((_) async => 'Reply');

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) =>
              ChatBloc(chatServices: mockServices)..add(LoadMessages('user1')),
          child: const ChatPage(userId: 'user1', userName: 'Alice'),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Hi');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    expect(find.text('Hi'), findsOneWidget);
  });
}
