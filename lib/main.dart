import 'package:flutter/material.dart';
import 'package:hot_potato/routing/route_paths.dart';
import 'package:hot_potato/routing/router.dart';
import 'package:hot_potato/ui/main/widgets/main_widget.dart';
import 'package:hot_potato/ui/math_challenge/view_model/math_challenge_viewmodel.dart';
import 'package:hot_potato/ui/timer/view_model/timer_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  List<SingleChildWidget> availableProviders = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    availableProviders.add(
      ChangeNotifierProvider(
        create: (context) {
          return TimerViewModel();
        },
      ),
    );
    availableProviders.add(
      ChangeNotifierProvider(
        create: (context) {
          return MathChallengeViewModel();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: availableProviders,
      child: MaterialApp(
        initialRoute: RoutePaths.homeRoute,
        onGenerateRoute: AppRouter.generateRoute,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.blue,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: MainWidget(),
      ),
    );
  }
}
