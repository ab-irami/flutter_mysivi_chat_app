import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mysivi_chat_app/models/message_model.dart';
import 'package:flutter_mysivi_chat_app/services/chat_services.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatServices _chatServices = ChatServices();

  ChatBloc() : super(ChatInitial()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<ReceiveMessage>(_onReceiveMessage);
  }

  Future<void> _onLoadMessages(
    LoadMessages event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());

    emit(ChatLoaded(messages: []));
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    final currentState = state;

    List<MessageModel> messages = [];
    if (currentState is ChatLoaded) {
      messages = List.of(currentState.messages);
    }

    final outgoing = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: event.message,
      timestamp: DateTime.now(),
      senderId: 'me',
    );

    messages.add(outgoing);

    emit(ChatLoaded(messages: messages, isTyping: true));

    try {
      await Future.delayed(const Duration(milliseconds: 600));

      final replyText = await _chatServices.fetchRandomMessage();

      final incoming = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: replyText,
        timestamp: DateTime.now(),
        senderId: event.userId,
      );

      emit(ChatLoaded(messages: [...messages, incoming], isTyping: false));
    } catch (e) {
      emit(ChatLoaded(messages: messages, isTyping: false));

      emit(ChatError('Failed to send message'));
    }
  }

  void _onReceiveMessage(ReceiveMessage event, Emitter<ChatState> emit) {
    final currentState = state;

    if (currentState is ChatLoaded) {
      final updated = List<MessageModel>.from(currentState.messages)
        ..add(event.message);

      emit(ChatLoaded(messages: updated, isTyping: false));
    }
  }
}
