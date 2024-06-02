import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fullstack_fe/feature/websocket/models/websocket_model.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@prod
@lazySingleton
abstract class WebsocketClient {
  @factoryMethod
  factory WebsocketClient() = WebsocketClientImpl;

  Future<void> connectWebsocket(
      Function(WebsocketMessage message) onMessageReceived,
      {bool isBroadcasting = false,
      required String roomId});
  Future<void> closeWebsocket();
  void sendWebsocketMessage(String message);
}

class WebsocketClientImpl implements WebsocketClient {
  WebSocketChannel? _channel;

  @override
  Future<void> closeWebsocket() async {
    if (_channel != null) {
      await _channel!.sink.close();
      _channel = null;
    }
  }

  @override
  Future<void> connectWebsocket(
      Function(WebsocketMessage message) onMessageReceived,
      {bool isBroadcasting = false,
      required String roomId}) async {
    _channel = WebSocketChannel.connect(Uri.parse(
        "${dotenv.env['WS_URL']!}/ws/$roomId?isBroadcast=$isBroadcasting"));
    _channel!.stream.listen((event) {
      Map<String, dynamic> data = jsonDecode(event);
      final message = WebsocketMessage.fromJson(data);

      onMessageReceived(message);
    });
  }

  @override
  void sendWebsocketMessage(String message) {
    if (_channel != null) {
      _channel!.sink.add(message);
    }
  }
}
