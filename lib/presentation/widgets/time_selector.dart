
import 'package:flutter/material.dart';



class TimeSelector extends StatelessWidget {
  const TimeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Button(text: 'Solana',
          onPressed: () {  },),
        SizedBox( width: 10,),
        _Button(text: 'Local',
          onPressed: () {  },),
        SizedBox( width: 10,),
        _Button(text: 'Both',
          onPressed: () {  },),
      ],
    );
  }
}


class _Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const _Button({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}
