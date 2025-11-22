

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_time/di/service_locator.dart';
import 'package:solana_time/domain/repository/api.dart';

import '../../../generated/l10n.dart';
import '../../styles/text_styles.dart';
import '../bloc/main_bloc.dart';
import '../widgets/run_stop_button.dart';
import '../widgets/time_display_card.dart';
import '../widgets/time_selector.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
      create: (BuildContext context) => MainBloc(api: getIt<MainApi>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).appTitle, style: CommonTextStyles.white24bold,),
          backgroundColor: Colors.deepPurple,
        ),
        body: const Stack(
          children: [
            Center(child:
             Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TimeSelector(),
                SizedBox(height: 20,),
                TimeDisplayCard(),
              ],
            )),
            Positioned(
                right: 50,
                bottom: 50,
                child: RunStopButton()),

          ],
        ),
      ),
    );
  }
}
