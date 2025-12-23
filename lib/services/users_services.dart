import 'package:flutter_mysivi_chat_app/models/user_model.dart';

abstract class UserServices {
  Future<void> addUser(String name);
  Future<List<UserModel>> getAllUsers();
}

class UsersServicesImpl implements UserServices {
  UsersServicesImpl._();

  static final UsersServicesImpl instance = UsersServicesImpl._();
  final List<UserModel> _users = [
    UserModel(
      id: '1',
      name: 'Alice',
      isOnline: true,
      lastActive: DateTime.now().subtract(Duration(seconds: 30)),
    ),
    UserModel(
      id: '2',
      name: 'Bob',
      isOnline: false,
      lastActive: DateTime.now().subtract(Duration(hours: 2)),
    ),
  ];

  @override
  Future<void> addUser(String name) async {
    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      isOnline: false,
      lastActive: DateTime.now(),
    );
    _users.add(newUser);
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    return _users;
  }
}
