import 'package:flutter/material.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@prod
@LazySingleton()
class AppRouter {
  final GlobalKey<NavigatorState> navigatorKey;
  AppRouter(
    this.navigatorKey,
  );
}
