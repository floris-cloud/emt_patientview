import 'dart:async';


import 'package:web_socket_channel/web_socket_channel.dart';
// TODO für Krankenkarte empfangen
class WebSocketService {
  static String host = 'floris-20df0051ge.local:8020';
  // static String host = 'localhost:8020';
  static String get url => 'ws://$host/ws';
  late final WebSocketChannel _channel;

  WebSocketService() {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));
      print('Connected to WebSocket');
    } catch (e) {
      print('Connection error: $e');
      // Handle connection errors (e.g., retry logic)
    }
  }

  Stream getChangeStream() {
    return _channel.stream.asBroadcastStream();
  }

}
final Stream webSocketStream = WebSocketService().getChangeStream();
