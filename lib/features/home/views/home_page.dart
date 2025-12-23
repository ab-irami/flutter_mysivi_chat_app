import 'package:flutter/material.dart';
import 'package:flutter_mysivi_chat_app/core/themes/app_colors.dart';
import 'package:flutter_mysivi_chat_app/core/utils/responsive.dart';
import 'package:flutter_mysivi_chat_app/features/home/tabs/chat_history/views/chat_history_tab.dart';
import 'package:flutter_mysivi_chat_app/features/home/tabs/users/views/users_tab.dart';
import 'package:flutter_mysivi_chat_app/core/extensions/context_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (widgets, innerBoxIsScrolled) => [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.2),
              sliver: SliverAppBar(
                pinned: false,
                floating: true,
                snap: true,
                toolbarHeight: 0,
                elevation: 0,
                backgroundColor: Colors.transparent,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(Responsive.w(44)),
                  child: Container(
                    height: Responsive.w(40),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(Responsive.w(20)),
                    ),
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      overlayColor: const WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                      indicator: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(Responsive.w(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey.shade600,
                      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                      tabs: const [
                        Tab(text: 'Users'),
                        Tab(text: 'Chat History'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
          body: const TabBarView(
            physics: ScrollPhysics(),
            children: [UsersTab(), ChatHistoryTab()],
          ),
        ),
      ),
    );
  }
}
