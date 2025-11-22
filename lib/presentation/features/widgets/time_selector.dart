
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../styles/text_styles.dart';
import '../bloc/events/main_event.dart';
import '../bloc/main_bloc.dart';
import '../bloc/state/main_state.dart';
import '../bloc/state/state_types.dart';
import '../utils/get_title_for_selector.dart';



class TimeSelector extends StatelessWidget {
  const TimeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MainBloc, MainState, TimeSource>(
      selector: (state) => state.timeState,
      builder: (BuildContext context, TimeSource timeState) {

        return Row(
        mainAxisSize: MainAxisSize.min,
        children: [

        _Button(
          btnState: TimeSource.solana,
          activeState: timeState,),

        const SizedBox( width: 10,),

          _Button(
            btnState: TimeSource.local,
            activeState: timeState,),

        const SizedBox( width: 10,),

          _Button(
            btnState: TimeSource.both,
            activeState: timeState,),
        ],
        );
      },

    );
  }
}


class _Button extends StatelessWidget {
  final TimeSource btnState;
  final TimeSource activeState;
  const _Button({required this.btnState, required this.activeState});

  @override
  Widget build(BuildContext context) {
    final locale = S.of(context);
    return ElevatedButton(
        onPressed: () {
          switch (btnState) {
            case TimeSource.solana:
              BlocProvider.of<MainBloc>(context).add(SolanaTimeEvent());
            case TimeSource.local:
              BlocProvider.of<MainBloc>(context).add(ClientTimeEvent());
            case TimeSource.both:
              BlocProvider.of<MainBloc>(context).add(BothTimeEvent());
          }

        },
        style: ElevatedButton.styleFrom(
            backgroundColor: btnState == activeState ? Colors.green : Colors.grey,
            padding: EdgeInsets.all(20)
        ),
        child: Text(getBtnTitle(btnState, locale), style: CommonTextStyles.white18bold,)
    );
  }
}
