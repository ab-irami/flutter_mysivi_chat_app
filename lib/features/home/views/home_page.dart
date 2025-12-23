import 'package:flutter/material.dart';
import 'package:flutter_mysivi_chat_app/core/themes/app_colors.dart';
import 'package:flutter_mysivi_chat_app/core/utils/responsive.dart';
import 'package:flutter_mysivi_chat_app/features/home/tabs/chat_history/views/chat_history_tab.dart';
import 'package:flutter_mysivi_chat_app/features/home/tabs/users/views/users_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 0,

          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Responsive.w(56)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.w(78)),
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

        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [UsersTab(), ChatHistoryTab()],
        ),
      ),
    );
  }
}
