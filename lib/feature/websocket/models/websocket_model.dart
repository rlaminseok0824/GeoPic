import 'package:freezed_annotation/freezed_annotation.dart';

part 'websocket_model.freezed.dart';
part 'websocket_model.g.dart';

@freezed
class WebsocketMessage with _$WebsocketMessage {
  factory WebsocketMessage({
    required String event,
    required String data,
    String? id,
  }) = _WebsocketMessage;

  WebsocketMessage._();

  factory WebsocketMessage.fromJson(Map<String, dynamic> json) =>
      _$WebsocketMessageFromJson(json);
}
