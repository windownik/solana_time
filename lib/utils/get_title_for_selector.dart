

import '../presentation/bloc/events/main_event.dart';


String getBtnTitle(MainEvents event) {
  switch (event) {
    case SolanaTime():
      return "Solana time";
    case ClientTime():
      return "Client time";
    case BothTime():
      return "Both Time";
    default:
      return "Both time";
  }
}