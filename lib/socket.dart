// import 'package:flutter/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:dostpravo/incoming_call/incoming_call.dart';
// import 'package:dostpravo/services/navigation_helper.dart';
import 'value.dart';
import 'vox.dart';
import 'dart:convert' show json;
import 'package:web_socket_channel/io.dart';
import 'package:video_call/services/auth_service.dart';
import 'package:video_call/services/call/call_service.dart';
// import 'state.dart';
// import 'home_page.dart';
// import 'package:provider/provider.dart';

WebSocketsNotifications sockets = new WebSocketsNotifications();

class WebSocketsNotifications {
  static final WebSocketsNotifications _sockets =
      new WebSocketsNotifications._internal();
  factory WebSocketsNotifications() {
    return _sockets;
  }
  WebSocketsNotifications._internal();
  IOWebSocketChannel _channel;
  bool _isOn = false;
  initCommunication(user) async {
    reset();
    try {
      _channel = new IOWebSocketChannel.connect(socket);
      _isOn = true;
      _channel.stream.listen(_onReceptionOfMessageFromServer);
    } catch (e) {
      print('error');
      print(e);

      /// General error handling
    }
  }

  /// Closes the WebSocket communication
  reset() {
    if (_channel != null) {
      if (_channel.sink != null) {
        _channel.sink.close();
        _isOn = false;
      }
    }
  }

  /// Sends a message to the server
  send(Map message) {
    if (_channel != null) {
      if (_channel.sink != null && _isOn) {
        _channel.sink.add(json.encode(message).codeUnits);
      }
    }
  }

  _onReceptionOfMessageFromServer(message) {
    print(message);
    var response = json.decode(message);
    if (response['command'] == "chat_message") {
      print('message our =  ${response['message']}');
      if (response['message'] == 'Начинаем звонок') {
        print('init_call2 ');
      }
    }
    if (response['command'] == "init_call") {
      registerVoximplant(response['lawyer_id_socket']);
      // AuthService();
      // CallService();
      print('init_call ');
      // Future.delayed(Duration(milliseconds: 1000), () => {}).then((value) =>
      //     NavigationHelper.pushToIncomingCall(caller: 'Доступное право'));
    }
  }
}
