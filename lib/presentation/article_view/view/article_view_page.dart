import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/presentation/article_view/bloc/article_view_cubit.dart';
import 'package:fullstack_fe/presentation/article_view/view/article_list.dart';
import 'package:fullstack_fe/presentation/common/scaffolds/backward_scaffold.dart';

class ArticleViewPage extends StatefulWidget {
  const ArticleViewPage({super.key});

  @override
  State<ArticleViewPage> createState() => _ArticleViewPageState();
}

class _ArticleViewPageState extends State<ArticleViewPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => getIt<ArticleViewCubit>()..load(0, 0),
      )
    ], child: const BackwardScaffold(body: ArticleList(), appBarHeight: 56));
  }
}
