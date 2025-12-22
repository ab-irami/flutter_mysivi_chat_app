import 'package:flutter/material.dart';
import 'package:flutter_mysivi_chat_app/features/home/tabs/chat_history/views/chat_history_tab.dart';
import 'package:flutter_mysivi_chat_app/features/home/tabs/users/views/users_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (widgets, context) => [
          const SliverAppBar(
            pinned: true,
            floating: true,
            snap: false,
            bottom: TabBar(
              tabs: [
                Tab(text: 'Users'),
                Tab(text: 'Chat History'),
              ],
            ),
          ),
        ],
        body: const TabBarView(
          physics: ScrollPhysics(),
          children: [UsersTab(), ChatHistoryTab()],
        ),
      ),
    );
  }
}
