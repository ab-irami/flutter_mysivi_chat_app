part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<MessageModel> messages;
  final bool isTyping;

  ChatLoaded({required this.messages, this.isTyping = false});
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
