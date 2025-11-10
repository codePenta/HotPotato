import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final Duration _duration;

  const TimerWidget(this._duration, {super.key});

  @override
  State<StatefulWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ElevatedButton(onPressed: onPressed, child: Text("Start game")),
        ],
      ),
    );
  }
}
