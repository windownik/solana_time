

import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

///
///
/// I make this code with OpenAi
///
///
///
class SolanaApi {
  static const String url = "wss://mainnet.helius-rpc.com/?api-key=f25fb01f-c70a-4e75-a0f5-ecbc2de5627e";
  // static const String url = "wss://devnet.helius-rpc.com/?api-key=f25fb01f-c70a-4e75-a0f5-ecbc2de5627e";
  WebSocketChannel? _channel;
  StreamController<DateTime>? _controller;

  final payload = {
    "jsonrpc": "2.0",
    "id": 1,
    "method": "accountSubscribe",
    "params": [
      "SysvarC1ock11111111111111111111111111111111",
      {
        "encoding": "base64",
        "commitment": "confirmed"
      }
    ]
  };


  Stream<DateTime> startSolanaStream() {
    if (_controller != null) return _controller!.stream;
    _controller = StreamController<DateTime>.broadcast();
    _channel = WebSocketChannel.connect(Uri.parse(url));

    _channel!.sink.add(jsonEncode(payload));

    _channel!.stream.listen((rawData) {
      if (_channel == null) return;
      try {
        final jsonData = jsonDecode(rawData);
        if (jsonData["method"] != "accountNotification") return;

        final base64data = jsonData["params"]["result"]["value"]["data"][0];
        final bytes = base64Decode(base64data);
        final unixTs = readUInt64LE(bytes, 8);
        final dt =
        DateTime.fromMillisecondsSinceEpoch(unixTs * 1000, isUtc: true)
            .toLocal();
        if (_controller == null) return;

        if (_controller!.isClosed) return;

        _controller?.add(dt);
      } catch (e) {
        print(["Solana Stream Error", e]);
      }

    },
        onError: (e) {
          print(["Solana Stream Error", e]);
    }, onDone: () {
          print("Solana WebSocket closed",);
        }
    );

    return _controller!.stream;

  }



  void cancel() {
    _channel?.sink.close();
    _channel = null;
    _controller?.close();
    _controller = null;
  }
}


// Helper for reading u64 on Flutter Web
int readUInt64LE(Uint8List bytes, int offset) {
  int result = 0;
  for (int i = 0; i < 8; i++) {
    result |= (bytes[offset + i] & 0xFF) << (8 * i);
  }
  return result;
}