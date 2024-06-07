import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/feature/live_stream/models/live_stream_record.dart';
import 'package:fullstack_fe/feature/websocket/models/websocket_model.dart';
import 'package:fullstack_fe/feature/websocket/repositories/websocket_repository.dart';
import 'package:fullstack_fe/presentation/common/buttons/app_elevated_button.dart';
import 'package:intl/intl.dart';

class LivestreamScreen extends StatefulWidget {
  final LiveStreamRecord record;

  const LivestreamScreen({super.key, required this.record});

  @override
  State<LivestreamScreen> createState() => _LivestreamScreenState();
}

class _LivestreamScreenState extends State<LivestreamScreen> {
  late RTCPeerConnection _peerConnection;
  late RTCSessionDescription? remoteDesc;
  List _remoteRenderers = [];
  bool _isCandidate = false;
  late WebsocketRepository _websocketRepository;

  @override
  void initState() {
    super.initState();
    _websocketRepository = getIt<WebsocketRepository>();
    init();
  }

  Future<void> init() async {
    await initWebRTC();
    initWS();
  }

  void initWS() async {
    try {
      await _websocketRepository.connectWebsocket(
        (message) => _handleWebSocketMessage(message),
        roomId: "123",
        isBroadcasting: false,
      );
    } catch (e) {
      print("error : $e");
    }
  }

  void _handleWebSocketMessage(WebsocketMessage message) async {
    switch (message.event) {
      case "lsp":
        var bytes = base64Decode(message.data);
        var decoded = utf8.decode(bytes);
        var sdp = jsonDecode(decoded);
        RTCSessionDescription realSdp =
            RTCSessionDescription(sdp['sdp'], sdp['type']);
        await _peerConnection.setRemoteDescription(realSdp);

        final sendBody = const JsonEncoder()
            .convert({'type': "test", 'sdp': "test", 'id': "test"});

        var bytes2 = utf8.encode(sendBody);
        var base64Str = base64.encode(bytes2);

        sendMessage(const JsonEncoder()
            .convert({'event': 'track', 'data': base64Str, 'id': "video"}));
        break;
      case "track":
        print(message.data);
        break;
    }
  }

  void sendMessage(String message) {
    _websocketRepository.sendWebsocketMessage(message);
  }

  Future<void> initWebRTC() async {
    _peerConnection = await createPeerConnection(
      {
        'iceServers': [
          {'urls': 'stun:stun.l.google.com:19302'},
        ]
      },
      {},
    );

    _peerConnection.onIceCandidate = (event) {
      if (event.candidate != null && !_isCandidate) {
        setState(() {
          _isCandidate = true;
        });
      }
    };

    _peerConnection.addTransceiver(
        kind: RTCRtpMediaType.RTCRtpMediaTypeVideo,
        init: RTCRtpTransceiverInit(
          direction: TransceiverDirection.SendRecv,
        ));

    _peerConnection
        .createOffer()
        .then((offer) => _peerConnection.setLocalDescription(offer));

    _peerConnection.onTrack = (event) async {
      if (event.track.kind == 'video' && event.streams.isNotEmpty) {
        var renderer = RTCVideoRenderer();
        await renderer.initialize();
        renderer.srcObject = event.streams[0];

        setState(() {
          _remoteRenderers.add(renderer);
        });
      }
    };

    _peerConnection.onRemoveStream = (stream) {
      // Set the new renderer list
      setState(() {
        stream.dispose();
        _remoteRenderers = [];
      });
    };
  }

  @override
  void dispose() {
    _peerConnection.dispose();
    _remoteRenderers = [];
    _websocketRepository.closeWebsocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildTitle(widget.record),
          const SizedBox(height: 10),
          _buildUsernameAndData(widget.record),
          const SizedBox(height: 24),
          _buildVideos(),
          const SizedBox(height: 24),
          _buildButton(context, widget.record),
          const SizedBox(height: 24),
          _buildDescription(widget.record),
        ]),
        const Spacer(),
        Column(
          children: [
            _buildLocation(widget.record),
            const SizedBox(height: 12),
            _buildTags(widget.record),
            const SizedBox(height: 48),
          ],
        )
      ],
    );
  }

  Widget _buildVideos() {
    return Row(
      children: _remoteRenderers.isNotEmpty
          ? _remoteRenderers.map((remoteRenderer) {
              return Center(
                child: Container(
                    height: 250,
                    width: 300,
                    color: AppColors.background,
                    child: RTCVideoView(remoteRenderer)),
              );
            }).toList()
          : [
              Center(
                child: Container(
                  height: 250,
                  width: 300,
                  decoration: BoxDecoration(
                    color: AppColors.greyPrimary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
            ],
    );
  }

  static Row _buildTitle(LiveStreamRecord record) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(record.title!,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildButton(BuildContext context, LiveStreamRecord record) {
    return _isCandidate
        ? AppElevatedButton(
            onPressed: () async {
              final lsd = await _peerConnection.getLocalDescription();
              final sendBody = const JsonEncoder()
                  .convert({'type': lsd!.type, 'sdp': lsd.sdp});

              var bytes = utf8.encode(sendBody);
              var base64Str = base64.encode(bytes);
              _websocketRepository.sendWebsocketMessage(const JsonEncoder()
                  .convert(
                      {'event': 'offer', 'data': base64Str, 'id': "video"}));
            },
            text: "참여하기",
            isDisabled: !_isCandidate,
            isLoading: false)
        : const SizedBox();
  }

  static Widget _buildDescription(LiveStreamRecord record) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(record.content!,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
        ),
      ],
    );
  }

  static Row _buildTags(LiveStreamRecord record) {
    return Row(
      children: record.tags
          .map((tag) => Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(tag,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ))
          .toList(),
    );
  }

  static Row _buildLocation(LiveStreamRecord record) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: AppColors.point,
            ),
            const SizedBox(width: 8),
            Text(record.location!),
          ],
        ),
        Row(
          children: [
            _buildLatitude(record),
            const SizedBox(width: 8),
            _buildLongitude(record),
          ],
        )
      ],
    );
  }

  static Row _buildUsernameAndData(LiveStreamRecord record) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.person),
            const SizedBox(width: 8),
            Text(record.username!),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.calendar_today),
            const SizedBox(width: 8),
            Text(DateFormat('yyyy-MM-dd').format(record.date.toLocal())),
          ],
        )
      ],
    );
  }

  static Row _buildLatitude(LiveStreamRecord record) {
    return Row(
      children: [
        const Text('위도'),
        const SizedBox(width: 8),
        Text(record.latitude!.toStringAsFixed(3)),
      ],
    );
  }

  static Row _buildLongitude(LiveStreamRecord record) {
    return Row(
      children: [
        const Text('경도'),
        const SizedBox(width: 8),
        Text(record.longitude!.toStringAsFixed(3)),
      ],
    );
  }
}
