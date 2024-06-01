import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';

class LiveStreamRecordVideo extends StatefulWidget {
  const LiveStreamRecordVideo({super.key});

  @override
  State<LiveStreamRecordVideo> createState() => _ArticleRecordPictureState();
}

class _ArticleRecordPictureState extends State<LiveStreamRecordVideo> {
  final _localRenderer = RTCVideoRenderer();
  late final RTCPeerConnection _peerConnection;
  RTCSessionDescription? _remoteDescription;
  bool _isCandidate = false;

  @override
  void initState() {
    super.initState();
    initWebRTC();
  }

  Future<void> initWebRTC() async {
    _peerConnection = await createPeerConnection({
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ]
    }, {});

    await _localRenderer.initialize();
    var localStream = await navigator.mediaDevices
        .getUserMedia({'audio': true, 'video': true});
    _localRenderer.srcObject = localStream;

    localStream.getTracks().forEach((track) {
      _peerConnection.addTrack(track, localStream);
    });

    _peerConnection.onIceCandidate = (event) {
      if (event.candidate != null && !_isCandidate) {
        setState(() {
          _isCandidate = true;
        });
      }
    };

    _peerConnection
        .createOffer()
        .then((offer) => _peerConnection.setLocalDescription(offer));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      _localRenderer,
                      mirror: true,
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }
}
