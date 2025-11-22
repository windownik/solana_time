import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../styles/text_styles.dart';
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
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.processState == ProcessStatus.stop)
                Text(
                  S.of(context).statusStop,
                  style: CommonTextStyles.white18bold,
                ),

              if (state.connectionState == ConnectionStatus.connecting)
                CircularProgressIndicator(),

              if (state.processState == ProcessStatus.run &&
                  state.localDateTime != null &&
                  (state.timeState == TimeSource.local ||
                      state.timeState == TimeSource.both))
                Text(
                  "${state.localDateTime}",
                  style: CommonTextStyles.white18bold,
                ),

              if (state.processState == ProcessStatus.run &&
                  state.solanaDateTime != null &&
                  (state.timeState == TimeSource.solana ||
                      state.timeState == TimeSource.both))
                Text(
                  "${state.solanaDateTime}",
                  style: CommonTextStyles.white18bold,
                ),
            ],
          ),
        );
      },
    );
  }
}
