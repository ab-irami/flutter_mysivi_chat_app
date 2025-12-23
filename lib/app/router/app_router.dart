import 'package:flutter/material.dart';
import 'package:flutter_mysivi_chat_app/app/observers/navigation_observer.dart';
import 'package:flutter_mysivi_chat_app/app/router/app_routes.dart';
import 'package:flutter_mysivi_chat_app/features/chat/views/chat_page.dart';
import 'package:flutter_mysivi_chat_app/features/dashboard/views/dashboard_page.dart';
import 'package:flutter_mysivi_chat_app/features/home/views/home_page.dart';
import 'package:flutter_mysivi_chat_app/features/offers/views/offers_page.dart';
import 'package:flutter_mysivi_chat_app/features/profile/views/profile_page.dart';
import 'package:flutter_mysivi_chat_app/features/splash/views/splash_page.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  observers: [AppNavigationObserver()],
  initialLocation: AppRoutes.splash,
  routes: [
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              name: AppRouteNames.home,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.offers,
              name: AppRouteNames.offers,
              builder: (context, state) => const OffersPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              name: AppRouteNames.profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
      builder: (context, state, navigationShell) =>
          DashboardPage(navigationShell: navigationShell),
    ),

    GoRoute(
      path: AppRoutes.chat,
      name: AppRouteNames.chat,
      builder: (context, state) {
        return ChatPage();
      },
    ),

    GoRoute(
      path: AppRoutes.splash,
      name: AppRouteNames.splash,
      builder: (context, state) {
        return SplashView();
      },
    ),
  ],
);
