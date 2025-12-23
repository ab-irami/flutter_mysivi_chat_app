import 'package:flutter_mysivi_chat_app/models/chat_history_model.dart';

abstract class ChatHistoryServices {
  Future<List<ChatHistoryModel>> getChatHistory();
}

class ChatHistoryServicesImpl implements ChatHistoryServices {
  final List<ChatHistoryModel> _chatHistories = [
    ChatHistoryModel(
      id: '1',
      userId: '1',
      timestamp: DateTime.now().subtract(Duration(minutes: 10)),
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

  @override
  Future<List<ChatHistoryModel>> getChatHistory() async {
    return _chatHistories;
  }
}
