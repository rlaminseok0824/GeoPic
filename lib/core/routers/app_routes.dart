import 'package:flutter/material.dart';
import 'package:fullstack_fe/presentation/article/view/article_record_page.dart';
import 'package:fullstack_fe/presentation/article_view/view/article_view_page.dart';
import 'package:fullstack_fe/presentation/home/view/home_page.dart';
import 'package:fullstack_fe/presentation/search/view/search_page.dart';
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

@TypedGoRoute<ArticleRecordRoute>(
  path: ArticleRecordRoute.path,
)
class ArticleRecordRoute extends GoRouteData {
  static const path = '/article-record';
  const ArticleRecordRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ArticleRecordPage.builder(context, state);
}

@TypedGoRoute<SearchRoute>(
  path: SearchRoute.path,
)
class SearchRoute extends GoRouteData {
  static const path = '/search';
  const SearchRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      SearchPage.builder(context, state);
}

@TypedGoRoute<ArticleViewRoute>(
  path: ArticleViewRoute.path,
)
class ArticleViewRoute extends GoRouteData {
  static const path = '/article-view';

  final double? lat;
  final double? lng;
  const ArticleViewRoute({
    required this.lat,
    required this.lng,
  });
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ArticleViewPage.builder(context, state, lat, lng);
}
