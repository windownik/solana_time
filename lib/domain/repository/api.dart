


import 'dart:async';

import '../../data/sources/solana_time_source.dart';


class MainApi {
  StreamController<DateTime>? _localTimeController;
  Timer? _timer;
  SolanaApi solanaApi = SolanaApi();

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

  void closeLocalStream() {
    _timer?.cancel();
    _localTimeController?.close();
    _localTimeController = null;
    _timer = null;
  }


  Stream<DateTime> startSolanaStream() {
    return solanaApi.startSolanaStream();
  }


  void closeSolanaStream() {
    solanaApi.cancel();
  }



  void dispose() {
    solanaApi.cancel();
    closeLocalStream();
    closeSolanaStream();
  }
}
