

import 'dart:async';


class LocalTimeApi {
  StreamController<DateTime>? _localTimeController;
  Timer? _timer;

  Stream<DateTime> startLocalStream() {
    if (_localTimeController != null) {
      return _localTimeController!.stream;
    }
    _localTimeController = StreamController<DateTime>.broadcast();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_localTimeController == null) return;

      if (_localTimeController!.isClosed) return;
      _localTimeController?.add(DateTime.now());

    });
    return _localTimeController!.stream;
  }

  void cancel() {
    _timer?.cancel();
    _localTimeController?.close();
    _localTimeController = null;
    _timer = null;
  }
}