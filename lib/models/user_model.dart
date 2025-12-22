class UserModel {
  final String id;
  final String name;
  final bool isOnline;
  final DateTime lastActive;

  UserModel({
    required this.id,
    required this.name,
    required this.isOnline,
    required this.lastActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      isOnline: json['isOnline'],
      lastActive: DateTime.parse(json['lastActive']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isOnline': isOnline,
      'lastActive': lastActive.toIso8601String(),
    };
  }
}
