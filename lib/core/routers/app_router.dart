import 'package:flutter/material.dart';
import 'package:fullstack_fe/core/observers/app_router_observer.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/core/routers/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@prod
@LazySingleton()
class AppRouter {
  final GlobalKey<NavigatorState> navigatorKey;
  AppRouter(
    this.navigatorKey,
  );

  late final goRouter = GoRouter(
    navigatorKey: navigatorKey,
    observers: [getIt<AppRouterObserver>()],
    initialLocation: const HomeRoute().location,
    routes: $appRoutes,
  );
}
