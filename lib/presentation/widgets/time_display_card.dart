

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/main_bloc.dart';
import '../bloc/state/main_state.dart';
import '../bloc/state/state_types.dart';



class TimeDisplayCard extends StatelessWidget {
  const TimeDisplayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (BuildContext context, MainState state) {

          return Container(
            width: 300,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(16)
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.runningState == ProcessStatus.run && state.localDateTime != null)
                Text("${state.localDateTime}", style: TextStyle(
                    color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),

                if (state.runningState == ProcessStatus.run && state.solanaDateTime != null)
                  Text("${state.solanaDateTime}", style: TextStyle(
                      color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
              ],
            ),
          );
      },

    );
  }
}
