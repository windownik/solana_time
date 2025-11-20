

import 'package:flutter/material.dart';



class TimeDisplayCard extends StatelessWidget {
  const TimeDisplayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(16)
      ),
      alignment: Alignment.center,
      child: Text("${DateTime.now()}", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
    );
  }
}
