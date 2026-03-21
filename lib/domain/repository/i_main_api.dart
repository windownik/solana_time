import 'dart:async';

abstract interface class IMainApi {
  Stream<DateTime> startLocalStream();

  void closeLocalStream();

  Stream<DateTime> startSolanaStream();

  void closeSolanaStream();

  void dispose();
}
