import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_mysivi_chat_app/features/chat/bloc/chat_bloc.dart';

import '../../../helpers/mock_helpers.dart';

void main() {
  late MockChatServices mockChatServices;

  setUp(() {
    mockChatServices = MockChatServices();
  });

  group('ChatBloc', () {
    test('initial state is ChatInitial', () {
      final bloc = ChatBloc(chatServices: mockChatServices);
      expect(bloc.state, isA<ChatInitial>());
      bloc.close();
    });

    blocTest<ChatBloc, ChatState>(
      'LoadMessages emits ChatLoading then ChatLoaded',
      build: () {
        return ChatBloc(chatServices: mockChatServices);
      },
      act: (bloc) => bloc.add(LoadMessages('user1')),
      expect: () => [
        isA<ChatLoading>(),
        isA<ChatLoaded>().having((s) => s.messages.length, 'messages', 0),
      ],
    );

    blocTest<ChatBloc, ChatState>(
      'SendMessage adds outgoing and incoming messages',
      build: () {
        when(
          () => mockChatServices.fetchRandomMessage(),
        ).thenAnswer((_) async => 'Hello back');
        return ChatBloc(chatServices: mockChatServices);
      },
      act: (bloc) async {
        bloc.add(LoadMessages('user1'));
        await Future<void>.delayed(Duration.zero);
        bloc.add(SendMessage('user1', 'Hi'));
      },
      wait: const Duration(milliseconds: 700),
      expect: () => [
        isA<ChatLoading>(),
        isA<ChatLoaded>(),
        isA<ChatLoaded>(),
        isA<ChatLoaded>(),
      ],
      verify: (bloc) {
        final state = bloc.state as ChatLoaded;
        expect(state.messages.length, 2);
        expect(state.messages.first.content, 'Hi');
        expect(state.messages.last.content, 'Hello back');
      },
    );

    blocTest<ChatBloc, ChatState>(
      'SendMessage emits ChatError on service failure',
      build: () {
        when(
          () => mockChatServices.fetchRandomMessage(),
        ).thenThrow(Exception('network error'));
        return ChatBloc(chatServices: mockChatServices);
      },
      act: (bloc) async {
        bloc.add(LoadMessages('user1'));
        await Future<void>.delayed(Duration.zero);
        bloc.add(SendMessage('user1', 'Hi'));
      },
      wait: const Duration(milliseconds: 700),
      expect: () => [
        isA<ChatLoading>(),
        isA<ChatLoaded>(),
        isA<ChatLoaded>(),
        isA<ChatLoaded>(),
        isA<ChatError>(),
      ],
      verify: (bloc) {
        final state = bloc.state;
        expect(state, isA<ChatError>());
        expect((state as ChatError).message, 'Failed to send message');
      },
    );
  });
}
