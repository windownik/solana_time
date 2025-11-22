



import '../bloc/state/state_types.dart';

String getBtnTitle(TimeSource source) {
  switch (source) {
    case TimeSource.solana:
      return "Solana";
    case TimeSource.local:
      return "Client";
    case TimeSource.both:
      return "Both";
  }
}