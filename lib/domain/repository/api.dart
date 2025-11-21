


import 'dart:async';


class MainApi {
  StreamController<DateTime>? _controller;
  Timer? _timer;

  Stream<DateTime> startLocalStream() {
    if (_controller != null) {
      return _controller!.stream;
    }
    _controller = StreamController<DateTime>.broadcast();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_controller == null) return;

      if (_controller!.isClosed) return;
      print("run");
      _controller?.add(DateTime.now());

    });
    return _controller!.stream;
  }

  void closeLocalStream() {
    _timer?.cancel();
    _controller?.close();
    _controller = null;
    _timer = null;
  }


  void dispose() {
    closeLocalStream();
  }
}
