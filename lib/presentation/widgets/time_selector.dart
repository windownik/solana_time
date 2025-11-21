
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_time/presentation/bloc/main_bloc.dart';
import 'package:solana_time/presentation/bloc/state/main_state.dart';

import '../../utils/get_title_for_selector.dart';
import '../bloc/events/main_event.dart';
import '../bloc/state/state_types.dart';



class TimeSelector extends StatelessWidget {
  const TimeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MainBloc, MainState, TimeSource>(
      selector: (state) => state.timeState,
      builder: (BuildContext context, TimeSource timeState) {
        print(["TimeSelector", timeState]);

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
        child: Text(getBtnTitle(btnState), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)
    );
  }
}
