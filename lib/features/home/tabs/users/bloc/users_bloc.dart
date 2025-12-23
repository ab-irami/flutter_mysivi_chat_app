import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mysivi_chat_app/models/user_model.dart';
import 'package:flutter_mysivi_chat_app/services/users_services.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    on<LoadUsers>((event, emit) async {
      emit(UsersLoading());
      final users = await UsersServicesImpl.instance.getAllUsers();
      emit(UsersLoaded(users));
    });

    on<AddUser>((event, emit) async {
      final currentState = state;

      if (currentState is UsersLoaded) {
        try {
          emit(UsersLoading());
          await UsersServicesImpl.instance.addUser(event.name);

          final users = await UsersServicesImpl.instance.getAllUsers();

          emit(UsersLoaded(users));
        } catch (e) {
          emit(UsersError('Failed to add user'));
        }
      }
    });
  }
}
