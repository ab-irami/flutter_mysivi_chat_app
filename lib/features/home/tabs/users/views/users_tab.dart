import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mysivi_chat_app/core/extensions/context_extension.dart';
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
                    onPressed: () {
                      _buildAddUserBottomSheet(context);
                    },
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

  void _buildAddUserBottomSheet(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add New User",
                  style: context.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter user name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;

                    context.read<UsersBloc>().add(
                      AddUser(nameController.text.trim()),
                    );

                    Navigator.pop(sheetContext);
                    context.showSnack('User added successfully');
                  },
                  child: const Text('Add User'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
