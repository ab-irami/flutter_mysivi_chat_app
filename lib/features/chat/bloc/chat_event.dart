part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class LoadMessages extends ChatEvent {
  final String userId;

  LoadMessages(this.userId);
}

class SendMessage extends ChatEvent {
  final String userId;
  final String message;

  SendMessage(this.userId, this.message);
}

class ReceiveMessage extends ChatEvent {
  final MessageModel message;

  ReceiveMessage(this.message);
}
