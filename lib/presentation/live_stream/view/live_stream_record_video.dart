import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';
import 'package:fullstack_fe/presentation/live_stream/bloc/webrtc_cubit.dart';

class LiveStreamRecordVideo extends StatefulWidget {
  const LiveStreamRecordVideo({super.key});

  @override
  State<LiveStreamRecordVideo> createState() => _ArticleRecordPictureState();
}

class _ArticleRecordPictureState extends State<LiveStreamRecordVideo> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebRTCCubit, WebrtcState>(builder: (context, state) {
      return state.maybeWhen(
          connected: (peerConnection, localRenderer, isCandidate) {
            return _buildVideo(localRenderer);
          },
          orElse: () => const SizedBox.shrink());
    });
  }

  Widget _buildVideo(RTCVideoRenderer localRenderer) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 290,
              width: double.infinity,
              color: AppColors.secondary,
              child: OrientationBuilder(
                builder: (context, orientation) {
                  return RTCVideoView(
                    localRenderer,
                    mirror: true,
                  );
                },
              ),
            ),
          )
        ],
      ));
}
