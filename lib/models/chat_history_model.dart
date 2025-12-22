class ChatHistoryModel {
  final String id;
  final String userId;
  final String message;
  final String userName;
  final DateTime timestamp;

  ChatHistoryModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.message,
    required this.timestamp,
  });

  factory ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    return ChatHistoryModel(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
