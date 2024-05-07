import 'package:flutter/material.dart';
import 'package:fullstack_fe/presentation/home/view/home_page.dart';
import 'package:go_router/go_router.dart';

part 'app_routes.g.dart';

@TypedGoRoute<RootRoute>(
  path: RootRoute.path,
)
class RootRoute extends GoRouteData {
  static const path = '/';
  const RootRoute();
}

@TypedGoRoute<HomeRoute>(
  path: HomeRoute.path,
)
class HomeRoute extends GoRouteData {
  static const path = '/home';
  const HomeRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      HomePage.builder(context, state);
}
