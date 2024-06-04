import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:fullstack_fe/presentation/common/scaffolds/backward_scaffold.dart';

class LiveStreamBroadcastPage extends StatefulWidget {
  final RTCVideoRenderer localRenderer;
  const LiveStreamBroadcastPage({super.key, required this.localRenderer});

  // static Widget builder(
  //   BuildContext context,
  //   GoRouterState state,
  // ) {
  //   return const LiveStreamBroadcastPage();
  // }

  @override
  State<LiveStreamBroadcastPage> createState() =>
      _LiveStreamBroadcastPageState();
}

class _LiveStreamBroadcastPageState extends State<LiveStreamBroadcastPage> {
  Widget _buildColumn() => Column(
        children: [
          OrientationBuilder(builder: ((context, orientation) {
            return SizedBox(
              height: 500,
              child: RTCVideoView(widget.localRenderer, mirror: true),
            );
          }))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return BackwardScaffold(body: _buildColumn(), appBarHeight: 56);
  }
}
