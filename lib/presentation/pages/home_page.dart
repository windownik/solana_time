

import 'package:flutter/material.dart';

import '../widgets/run_stop_button.dart';
import '../widgets/time_display_card.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solana Time App", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          Center(child: TimeDisplayCard()),
          Positioned(
              right: 50,
              bottom: 50,
              child: RunStopButton()),

        ],
      ),
    );
  }
}
