import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mysivi_chat_app/models/chat_history_model.dart';
import 'package:flutter_mysivi_chat_app/services/chat_history_services.dart';

part 'chat_history_event.dart';
part 'chat_history_state.dart';

class ChatHistoryBloc extends Bloc<ChatHistoryEvent, ChatHistoryState> {
  final ChatHistoryServices _chatHistoryServices;
  ChatHistoryBloc({ChatHistoryServices? chatHistoryServices})
    : _chatHistoryServices =
          chatHistoryServices ?? ChatHistoryServicesImpl.instance,
      super(ChatHistoryInitial()) {
    on<LoadChatHistory>((event, emit) async {
      emit(ChatHistoryLoading());
      final chatHistories = await _chatHistoryServices.getChatHistory();
      emit(ChatHistoryLoaded(chatHistories));
    });
  }
}
