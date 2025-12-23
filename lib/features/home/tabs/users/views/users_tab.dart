import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mysivi_chat_app/core/extensions/string_extension.dart';
import 'package:flutter_mysivi_chat_app/core/widgets/online_indicator.dart';
import 'package:flutter_mysivi_chat_app/features/home/tabs/users/bloc/users_bloc.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersBloc()..add(LoadUsers()),
      child: BlocConsumer<UsersBloc, UsersState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UsersError) {
            return Center(child: Text(state.message));
          }

          if (state is UsersLoaded) {
            return Stack(
              children: [
                ListView.builder(
                  key: PageStorageKey("usersListView"),
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: OnlineIndicatorAvatar(
                        letter: state.users[index].name[0],
                        isOnline: state.users[index].isOnline,
                      ),
                      title: Text(state.users[index].name),
                      subtitle: Text(
                        state.users[index].lastActive.toString().lastActiveText,
                      ),
                    );
                  },
                ),

                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('No users found.'));
        },
      ),
    );
  }
}
