part of 'users_bloc.dart';

@immutable
sealed class UsersEvent {}

final class LoadUsers extends UsersEvent {}

final class AddUser extends UsersEvent {
  final String name;

  AddUser(this.name);
}

final class RefreshUsers extends UsersEvent {}
