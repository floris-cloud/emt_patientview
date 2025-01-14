import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final _channel = WebSocketChannel.connect(
  Uri.parse('ws://127.0.0.1:8765'),
  );

  Stream getChangeStream() {
    return _channel.stream.asBroadcastStream();
  }

  @override
  void dispose() {
    _channel.sink.close();
  }
}