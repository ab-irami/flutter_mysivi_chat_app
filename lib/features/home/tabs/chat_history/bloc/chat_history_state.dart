part of 'chat_history_bloc.dart';

@immutable
sealed class ChatHistoryState {}

final class ChatHistoryInitial extends ChatHistoryState {}

final class ChatHistoryLoading extends ChatHistoryState {}

final class ChatHistoryLoaded extends ChatHistoryState {
  final List<ChatHistoryModel> chatHistories;

  ChatHistoryLoaded(this.chatHistories);
}

final class ChatHistoryError extends ChatHistoryState {
  final String message;

  ChatHistoryError(this.message);
}

