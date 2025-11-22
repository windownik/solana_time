
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/events/main_event.dart';
import '../bloc/main_bloc.dart';
import '../bloc/state/main_state.dart';
import '../bloc/state/state_types.dart';

class RunStopButton extends StatelessWidget {
  const RunStopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MainBloc, MainState, ProcessStatus>(
      selector: (state) => state.processState,
      builder: (BuildContext context, ProcessStatus runningState) {
        print(["RunStopButton", runningState]);
        return ElevatedButton(
          onPressed: () {
            if (runningState == ProcessStatus.stop) {
              BlocProvider.of<MainBloc>(context).add(RunEvent());
            } else {
              BlocProvider.of<MainBloc>(context).add(StopEvent());
            }
          },
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: runningState == ProcessStatus.stop ? Colors.green : Colors.red,
              padding: EdgeInsets.all(20)
          ),
          child: Icon(runningState == ProcessStatus.stop ? Icons.play_arrow : Icons.pause ,
            color: Colors.white, size:30,),

        );
      }
    );
  }
}
