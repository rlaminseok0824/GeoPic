import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class AppRouterObserver extends RouteObserver<PageRoute<dynamic>> {
  final Logger _logger;

  AppRouterObserver(this._logger);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    logRoute(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    logRoute(route, previousRoute, isPop: true);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute == null || oldRoute == null) return;
    logReplaceRoute(oldRoute, newRoute);
  }

  void logRoute(
    Route<dynamic> route,
    Route<dynamic>? previousRoute, {
    bool isPop = false,
  }) {
    if (previousRoute == null) {
      return _logger
          .d('✈️  ->  ${route.settings.name}, ${route.settings.arguments}');
    }
    final firstRouteName = route.settings.name;
    final firstRouteArguments = route.settings.arguments;
    final secondRouteName = previousRoute.settings.name;
    final secondRouteArguments = previousRoute.settings.arguments;
    final previous = isPop
        ? '$firstRouteName, $firstRouteArguments'
        : '$secondRouteName, $secondRouteArguments';
    final current = isPop
        ? '$secondRouteName, $secondRouteArguments'
        : '$firstRouteName, $firstRouteArguments';
    _logger.d('✈️ $previous  ->  $current');
  }

  void logReplaceRoute(Route<dynamic> oldRoute, Route<dynamic> newRoute) {
    _logger.d('✈️ ${oldRoute.settings.name}, ${oldRoute.settings.arguments}'
        '  ->  ${newRoute.settings.name}, ${newRoute.settings.arguments}');
  }
}
