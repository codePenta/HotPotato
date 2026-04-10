import 'package:flutter/material.dart';
import 'package:hot_potato/routing/route_paths.dart';
import 'package:hot_potato/ui/starting/widgets/game_start_view.dart';

class GameStartScreen extends StatelessWidget {
  const GameStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameStartView(
      greetingsText: "Willkommen zu unserem Spiel!",
      onStartCallback: () =>
          Navigator.of(context).pushNamed(RoutePaths.startRoute),
    );
  }
}
