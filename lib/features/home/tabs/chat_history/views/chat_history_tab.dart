import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mysivi_chat_app/app/router/app_routes.dart';
import 'package:flutter_mysivi_chat_app/core/extensions/string_extension.dart';
import 'package:flutter_mysivi_chat_app/core/widgets/online_indicator.dart';
import 'package:flutter_mysivi_chat_app/features/home/tabs/chat_history/bloc/chat_history_bloc.dart';
import 'package:go_router/go_router.dart';

class ChatHistoryTab extends StatelessWidget {
  const ChatHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatHistoryBloc()..add(LoadChatHistory()),
      child: BlocBuilder<ChatHistoryBloc, ChatHistoryState>(
        builder: (context, state) {
          if (state is ChatHistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ChatHistoryError) {
            return Center(child: Text(state.message));
          }
          if (state is ChatHistoryLoaded) {
            return ListView.builder(
              key: PageStorageKey("usersListView"),
              itemCount: state.chatHistories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    context.pushNamed(
                      AppRouteNames.chat,
                      extra: {
                        'userId': state.chatHistories[index].userId,
                        'userName': state.chatHistories[index].userName,
                      },
                    );
                  },
                  leading: OnlineIndicatorAvatar(
                    letter: state.chatHistories[index].userName[0],
                    isOnline:
                        DateTime.now()
                            .difference(state.chatHistories[index].timestamp)
                            .inSeconds <
                        60,
                  ),
                  title: Text(state.chatHistories[index].userName),
                  subtitle: Text(state.chatHistories[index].message),

                  trailing: Text(
                    state.chatHistories[index].timestamp
                        .toString()
                        .shortLastActiveText,
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No chat history found.'));
        },
      ),
    );
  }
}
