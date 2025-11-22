


import 'dart:async';

import '../../data/sources/local_time_source.dart';
import '../../data/sources/solana_time_source.dart';


class MainApi {
  SolanaApi solanaApi = SolanaApi();
  LocalTimeApi localTimeApi = LocalTimeApi();


  Stream<DateTime> startLocalStream() {
    return localTimeApi.startLocalStream();
  }

  void closeLocalStream() {
    localTimeApi.cancel();
  }


  Stream<DateTime> startSolanaStream() {
    return solanaApi.startSolanaStream();
  }


  void closeSolanaStream() {
    solanaApi.cancel();
  }



  void dispose() {
    closeLocalStream();
    closeSolanaStream();
  }
}
