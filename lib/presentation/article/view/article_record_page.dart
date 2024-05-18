import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/presentation/article/bloc/article_record_cubit.dart';
import 'package:fullstack_fe/presentation/article/view/article_record_view.dart';
import 'package:fullstack_fe/presentation/common/scaffolds/backward_scaffold.dart';

class ArticleRecordPage extends StatefulWidget {
  const ArticleRecordPage({super.key});

  @override
  State<ArticleRecordPage> createState() => _ArticleRecordPageState();
}

class _ArticleRecordPageState extends State<ArticleRecordPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ArticleRecordCubit>()),
      ],
      child:
          const BackwardScaffold(body: ArticleRecordView(), appBarHeight: 50),
    );
    ;
  }
}
