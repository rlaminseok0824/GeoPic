import 'package:fullstack_fe/feature/websocket/datasources/websocket_client.dart';
import 'package:fullstack_fe/feature/websocket/models/websocket_model.dart';
import 'package:injectable/injectable.dart';

@prod
@LazySingleton()
class WebsocketRepository {
  final WebsocketClient _websocketClient;

  WebsocketRepository(this._websocketClient);

  Future<void> connectWebsocket(
      Function(WebsocketMessage message) onMessageReceived,
      {bool isBroadcasting = false,
      required String roomId}) async {
    await _websocketClient.connectWebsocket(onMessageReceived,
        isBroadcasting: isBroadcasting, roomId: roomId);
  }

  Future<void> closeWebsocket() async {
    await _websocketClient.closeWebsocket();
  }

  void sendWebsocketMessage(String message) {
    _websocketClient.sendWebsocketMessage(message);
  }
}
