class MessageModel {
  final String id;
  final String content;
  final DateTime timestamp;
  final String senderId;

  MessageModel({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.senderId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      senderId: json['senderId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'senderId': senderId,
    };
  }
}