import 'package:flutter/material.dart';

class GameStartView extends StatelessWidget {
  final String greetingsText;
  final VoidCallback onStartCallback;
  final TextStyle headingStyle = const TextStyle(fontSize: 20);

  const GameStartView({
    super.key,
    required this.greetingsText,
    required this.onStartCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(greetingsText, style: headingStyle),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onStartCallback,
                child: const Text("Start"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
