import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_time/di/service_locator.dart';

import '../../../domain/repository/i_main_api.dart';
import '../../../generated/l10n.dart';
import '../../styles/text_styles.dart';
import '../bloc/main_bloc.dart';
import '../widgets/run_stop_button.dart';
import '../widgets/time_display_card.dart';
import '../widgets/time_selector/time_selector_wrapper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
      create: (BuildContext context) => MainBloc(api: getIt<IMainApi>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).appTitle,
            style: CommonTextStyles.white24bold,
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: const Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TimeSelectorWrapper(),
                  SizedBox(height: 20),
                  TimeDisplayCard(),
                ],
              ),
            ),
            Positioned(right: 50, bottom: 50, child: RunStopButton()),
          ],
        ),
      ),
    );
  }
}
