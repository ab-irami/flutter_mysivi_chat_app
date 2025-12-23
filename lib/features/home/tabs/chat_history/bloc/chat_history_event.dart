part of 'chat_history_bloc.dart';

@immutable
sealed class ChatHistoryEvent {}

class LoadChatHistory extends ChatHistoryEvent {}
