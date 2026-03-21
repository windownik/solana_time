import 'dart:async';

import '../../domain/repository/i_main_api.dart';
import '../sources/local_time_source.dart';
import '../sources/solana_time_source.dart';

class MainApi implements IMainApi {
  SolanaApi solanaApi = SolanaApi();
  LocalTimeApi localTimeApi = LocalTimeApi();

  @override
  Stream<DateTime> startLocalStream() {
    return localTimeApi.startLocalStream();
  }

  @override
  void closeLocalStream() {
    localTimeApi.cancel();
  }

  @override
  Stream<DateTime> startSolanaStream() {
    return solanaApi.startSolanaStream();
  }

  @override
  void closeSolanaStream() {
    solanaApi.cancel();
  }

  @override
  void dispose() {
    closeLocalStream();
    closeSolanaStream();
  }
}
