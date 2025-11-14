import 'package:flutter/material.dart';
import 'package:hot_potato/ui/math_challenge/view_model/math_challenge_viewmodel.dart';
import 'package:hot_potato/ui/timer/view_model/timer_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:hot_potato/ui/timer/widgets/timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimerViewModel()),
        ChangeNotifierProvider(create: (_) => MathChallengeViewModel()),
      ],
      child: MaterialApp(
        title: 'Hot potato',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.blue,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: TimerWidget(),
      ),
    );
  }
}
