import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/presentation/common/scaffolds/submit_scaffold.dart';
import 'package:fullstack_fe/presentation/live_stream/bloc/live_stream_record_cubit.dart';
import 'package:go_router/go_router.dart';

class LiveStreamRecordPage extends StatefulWidget {
  const LiveStreamRecordPage._();

  static Widget builder(
    BuildContext context,
    GoRouterState state,
  ) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => getIt<LiveStreamRecordCubit>()),
    ], child: const LiveStreamRecordPage._());
  }

  @override
  State<LiveStreamRecordPage> createState() => _ArticleRecordPageState();
}

class _ArticleRecordPageState extends State<LiveStreamRecordPage> {
  void _onSubmit() => context.read<LiveStreamRecordCubit>().submit();

  void _onSubmitSucceed(BuildContext context, LiveStreamRecordState state) {
    state.maybeWhen(
        submitSucceed: (record) => context.pop(record), orElse: () => null);
  }

  Widget _buildColumn() => const Column(
        children: [],
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LiveStreamRecordCubit, LiveStreamRecordState>(
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
