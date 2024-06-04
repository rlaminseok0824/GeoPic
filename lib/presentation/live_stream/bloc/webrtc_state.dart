part of 'webrtc_cubit.dart';

@freezed
class WebrtcState with _$WebrtcState {
  const factory WebrtcState.initial() = _Initial;
  const factory WebrtcState.connected(
      {required RTCPeerConnection peerConnection,
      required RTCVideoRenderer localRenderer,
      required bool isCandidate}) = _Connected;
  const factory WebrtcState.closed() = _Closed;
  const factory WebrtcState.onRecevied(String message) = _OnRecevied;
}
