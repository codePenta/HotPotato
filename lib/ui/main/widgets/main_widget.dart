import 'package:flutter/material.dart';
import 'package:hot_potato/ui/timer/view_model/timer_viewmodel.dart';
import 'package:hot_potato/ui/timer/widgets/timer_widget.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidget();
}

class _MainWidget extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hot potato')),
      body: TimerWidget(),
    );
  }
}
