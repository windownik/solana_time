
import 'package:flutter/material.dart';

class RunStopButton extends StatelessWidget {
  const RunStopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        padding: EdgeInsets.all(20)
      ),
      child: Icon(Icons.play_arrow, color: Colors.white, size:30,),
      
    );
  }
}
