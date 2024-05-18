import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/presentation/article/bloc/article_record_cubit.dart';
import 'package:fullstack_fe/presentation/article/view/activity_record_location.dart';
import 'package:fullstack_fe/presentation/article/view/activity_record_position.dart';
import 'package:fullstack_fe/presentation/article/view/article_record_content.dart';
import 'package:fullstack_fe/presentation/article/view/article_record_picture.dart';
import 'package:fullstack_fe/presentation/article/view/article_record_title.dart';
import 'package:fullstack_fe/presentation/common/scaffolds/submit_scaffold.dart';
import 'package:go_router/go_router.dart';

class ArticleRecordPage extends StatefulWidget {
  const ArticleRecordPage._();

  static Widget builder(
    BuildContext context,
    GoRouterState state,
  ) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => getIt<ArticleRecordCubit>()),
    ], child: const ArticleRecordPage._());
  }

  @override
  State<ArticleRecordPage> createState() => _ArticleRecordPageState();
}

class _ArticleRecordPageState extends State<ArticleRecordPage> {
  void _onSubmit() => context.read<ArticleRecordCubit>().submit();

  void _onSubmitSucceed(BuildContext context, ArticleRecordState state) {
    state.maybeWhen(
        submitSucceed: (record) => context.pop(record), orElse: () => null);
  }

  Widget _buildColumn() => const Column(
        children: [
          ArticleRecordPicture(),
          ArticleRecordTitle(),
          ArticleRecordContent(),
          ArticleRecordLocation(),
          ArticleRecordPosition(),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleRecordCubit, ArticleRecordState>(
        listener: _onSubmitSucceed,
        builder: (context, state) {
          return SubmitScaffold(
              body: _buildColumn(),
              appBarHeight: 56,
              onSubmit: _onSubmit,
              canSubmit: !state.record.isUnfinished,
              isSubmitting: state.maybeWhen(
                  submitting: (_) => true, orElse: () => false));
        });
  }
}
