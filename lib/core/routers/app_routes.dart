import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'app_routes.g.dart';

@TypedGoRoute<RootRoute>(
  path: RootRoute.path,
)
class RootRoute extends GoRouteData {
  static const path = '/';
  const RootRoute();
}
