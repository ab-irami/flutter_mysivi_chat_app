import 'package:flutter/material.dart';
import 'package:flutter_mysivi_chat_app/app/observers/navigation_observer.dart';
import 'package:flutter_mysivi_chat_app/app/router/app_routes.dart';
import 'package:flutter_mysivi_chat_app/features/home/views/home_page.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  observers: [AppNavigationObserver()],
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: AppRouteNames.home,
      builder: (context, state) => HomePage(),
    ),
  ],
);
