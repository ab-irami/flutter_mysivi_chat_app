import 'package:flutter_mysivi_chat_app/models/chat_history_model.dart';
import 'package:flutter_mysivi_chat_app/models/user_model.dart';

abstract class ChatHistoryServices {
  Future<List<ChatHistoryModel>> getChatHistory();
}

class ChatHistoryServicesImpl implements ChatHistoryServices {
  ChatHistoryServicesImpl._();

  static final ChatHistoryServicesImpl instance = ChatHistoryServicesImpl._();

  final List<ChatHistoryModel> _chatHistories = [
    ChatHistoryModel(
      id: '1',
      userId: '1',
      timestamp: DateTime.now().subtract(Duration(seconds: 20)),
      userName: 'Alice',
      message: 'Hey, how are you?',
    ),
    ChatHistoryModel(
      id: '2',
      userId: '2',
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
      userName: 'Bob',
      message: 'Let\'s catch up later!',
    ),
  ];

  void ensureUsers(List<UserModel> users) {
    for (final user in users) {
      if (!_chatHistories.any((h) => h.userId == user.id)) {
        _chatHistories.add(
          ChatHistoryModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            userId: user.id,
            timestamp: user.lastActive,
            userName: user.name,
            message: 'Hello! This is my first message.',
          ),
        );
      }
    }
  }

  void addHistoryForUser(UserModel user) {
    _chatHistories.add(
      ChatHistoryModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: user.id,
        timestamp: user.lastActive,
        userName: user.name,
        message: 'Hey there! I just joined.',
      ),
    );
  }

  @override
  Future<List<ChatHistoryModel>> getChatHistory() async {
    return _chatHistories;
  }
}
