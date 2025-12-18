import 'package:flutter/material.dart';
import 'package:hot_potato/routing/route_paths.dart';
import 'package:hot_potato/ui/ending/widgets/game_ending_widget.dart';
import 'package:hot_potato/ui/main/widgets/main_widget.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.homeRoute:
        return MaterialPageRoute(builder: (_) => MainWidget());
      case RoutePaths.endingRoute:
        return MaterialPageRoute(builder: (_) => GameEndingWidget());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("No route defined for ${settings.name}")),
          ),
        );
    }
  }
}
