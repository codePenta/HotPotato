import 'package:flutter/material.dart';
import 'package:hot_potato/ui/starting/widgets/game_start_screen.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidget();
}

class _MainWidget extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    return GameStartScreen();
  }
}
