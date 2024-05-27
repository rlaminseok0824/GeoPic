import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/presentation/article_view/bloc/article_view_cubit.dart';
import 'package:fullstack_fe/presentation/article_view/view/article_list.dart';
import 'package:fullstack_fe/presentation/common/scaffolds/backward_scaffold.dart';
import 'package:go_router/go_router.dart';

class ArticleViewPage extends StatefulWidget {
  final double? lat;
  final double? lng;
  const ArticleViewPage({super.key, required this.lat, required this.lng});

  static Widget builder(
      BuildContext context, GoRouterState state, double? lat, double? lng) {
    return ArticleViewPage(lat: lat, lng: lng);
  }

  @override
  State<ArticleViewPage> createState() => _ArticleViewPageState();
}

class _ArticleViewPageState extends State<ArticleViewPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                getIt<ArticleViewCubit>()..load(widget.lat, widget.lng),
          )
        ],
        child: const BackwardScaffold(
          body: ArticleList(),
          appBarHeight: 40,
        ));
  }
}
