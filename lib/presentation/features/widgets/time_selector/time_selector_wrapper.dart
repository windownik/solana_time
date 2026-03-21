import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_time/presentation/features/widgets/time_selector/time_selector_view.dart';

import '../../bloc/events/main_event.dart';
import '../../bloc/main_bloc.dart';
import '../../bloc/state/main_state.dart';
import '../../bloc/state/state_types.dart';

class TimeSelectorWrapper extends StatelessWidget {
  const TimeSelectorWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    void _onTapSolanaTime(TimeSource btnState) {
      switch (btnState) {
        case TimeSource.solana:
          BlocProvider.of<MainBloc>(context).add(SolanaTimeEvent());
        case TimeSource.local:
          BlocProvider.of<MainBloc>(context).add(ClientTimeEvent());
        case TimeSource.both:
          BlocProvider.of<MainBloc>(context).add(BothTimeEvent());
      }
    }

    return BlocSelector<MainBloc, MainState, TimeSource>(
      selector: (state) => state.timeState,
      builder: (BuildContext context, TimeSource timeState) {
        return TimeSelectorView(
          onChangeSource: _onTapSolanaTime,
          activeTimeSource: timeState,
        );
      },
    );
  }
}
