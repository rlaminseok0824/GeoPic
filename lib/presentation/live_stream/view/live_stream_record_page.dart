import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/core/routers/app_routes.dart';
import 'package:fullstack_fe/presentation/common/scaffolds/submit_scaffold.dart';
import 'package:fullstack_fe/presentation/live_stream/bloc/live_stream_record_cubit.dart';
import 'package:fullstack_fe/presentation/live_stream/bloc/webrtc_cubit.dart';
import 'package:fullstack_fe/presentation/live_stream/view/live_stream_broadcast_page.dart';
import 'package:fullstack_fe/presentation/live_stream/view/live_stream_record_position.dart';
import 'package:fullstack_fe/presentation/live_stream/view/live_stream_record_title.dart';
import 'package:fullstack_fe/presentation/live_stream/view/live_stream_record_location.dart';
import 'package:fullstack_fe/presentation/live_stream/view/live_stream_record_video.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class LiveStreamRecordPage extends StatefulWidget {
  const LiveStreamRecordPage._();

  static Widget builder(
    BuildContext context,
    GoRouterState state,
  ) {
    final videoId = const Uuid().v4().toString();

    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) => getIt<WebRTCCubit>(
                param1: videoId,
              )),
      BlocProvider(
        create: (_) => getIt<LiveStreamRecordCubit>(param1: videoId),
      ),
    ], child: const LiveStreamRecordPage._());
  }

  @override
  State<LiveStreamRecordPage> createState() => _ArticleRecordPageState();
}

class _ArticleRecordPageState extends State<LiveStreamRecordPage> {
  void _onSubmit() async {
    context.read<LiveStreamRecordCubit>().submit();
    await context.read<WebRTCCubit>().sendLocalDescription().then((_) => context
        .read<LiveStreamRecordCubit>()
        .update((previous) =>
            previous.copyWith(videoId: context.read<WebRTCCubit>().videoId)));
  }

  void _onSubmitSucceed(BuildContext context, LiveStreamRecordState state) {
    state.maybeWhen(
        submitSucceed: (record) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => LiveStreamBroadcastPage(
                  localRenderer: context.read<WebRTCCubit>().localRenderer,
                ),
              ),
            ),
        orElse: () => null);
  }

  Widget _buildColumn() => const Column(
        children: [
          LiveStreamRecordVideo(),
          LiveStreamRecordTitle(),
          LiveStreamRecordLocation(),
          LiveStreamRecordPosition(),
        ],
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
