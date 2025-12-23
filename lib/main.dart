import 'package:flutter/material.dart';
import 'package:flutter_mysivi_chat_app/app/router/app_router.dart';
import 'package:flutter_mysivi_chat_app/core/themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MySivi Chat',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
