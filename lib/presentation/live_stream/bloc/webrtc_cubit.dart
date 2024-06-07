import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fullstack_fe/feature/websocket/models/websocket_model.dart';
import 'package:fullstack_fe/feature/websocket/repositories/websocket_repository.dart';
import 'package:injectable/injectable.dart';
part 'webrtc_state.dart';
part 'webrtc_cubit.freezed.dart';

@injectable
class WebRTCCubit extends Cubit<WebrtcState> {
  final WebsocketRepository _websocketRepository;
  late RTCPeerConnection _peerConnection;
  final RTCVideoRenderer localRenderer = RTCVideoRenderer();
  bool _isCandidate = false;
  // final String videoId;

  WebRTCCubit(this._websocketRepository) : super(const WebrtcState.initial()) {
    _initialize();
  }

  Future<void> _initialize() async {
    await setupWebRTC();
    setupWebSocketListener();
  }

  Future<void> setupWebRTC() async {
    _peerConnection = await createPeerConnection({
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ]
    }, {});

    await localRenderer.initialize();
    var localStream = await navigator.mediaDevices
        .getUserMedia({'audio': true, 'video': true});
    localRenderer.srcObject = localStream;

    localStream.getTracks().forEach((track) {
      _peerConnection.addTrack(track, localStream);
    });

    _peerConnection.onIceCandidate = (event) {
      if (event.candidate != null && !_isCandidate) {
        _isCandidate = true;
      }
    };

    _peerConnection
        .createOffer()
        .then((offer) => _peerConnection.setLocalDescription(offer));
  }

  Future<void> setupWebSocketListener() async {
    try {
      await _websocketRepository.connectWebsocket(
        (message) => _handleWebSocketMessage(message),
        roomId: "123",
        isBroadcasting: true,
      );
      emit(WebrtcState.connected(
          peerConnection: _peerConnection,
          localRenderer: localRenderer,
          isCandidate: _isCandidate));
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

  Future<void> closeWebSocket() async {
    await _websocketRepository.closeWebsocket();
  }

  void sendMessage(String message) {
    _websocketRepository.sendWebsocketMessage(message);
  }

  Future<void> sendLocalDescription() async {
    final lsd = await _peerConnection.getLocalDescription();
    final sendBody =
        const JsonEncoder().convert({'type': lsd!.type, 'sdp': lsd.sdp});

    var bytes = utf8.encode(sendBody);
    var base64Str = base64.encode(bytes);
    sendMessage(const JsonEncoder()
        .convert({'event': 'offer', 'data': base64Str, 'id': "video"}));
  }
}
