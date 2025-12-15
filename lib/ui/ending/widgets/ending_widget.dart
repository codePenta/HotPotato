import 'package:flutter/material.dart';

class EndingWidget extends StatelessWidget {
  final TextStyle headingStyle = TextStyle(fontSize: 20);

  EndingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.zero,
      child: Text("Game Over!", style: headingStyle),
    );
  }
}
