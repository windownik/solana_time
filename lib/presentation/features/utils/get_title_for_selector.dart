



import '../../../generated/l10n.dart';
import '../bloc/state/state_types.dart';

String getBtnTitle(TimeSource source, S locale) {
  switch (source) {
    case TimeSource.solana:
      return locale.selectorSolana;
    case TimeSource.local:
      return locale.selectorLocal;
    case TimeSource.both:
      return locale.selectorBoth;
  }
}