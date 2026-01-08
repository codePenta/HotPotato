import 'package:flutter/material.dart';
import 'package:hot_potato/ui/core/ui/animations/animated_entry_wrapper.dart';

class MathChallengeView extends StatelessWidget {
  final String mathChallenge;
  final TextEditingController editingController;
  final VoidCallback onSubmitCallback;

  const MathChallengeView({
    super.key,
    required this.mathChallenge,
    required this.editingController,
    required this.onSubmitCallback,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedEntryWrapper(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              mathChallenge,
              style: const TextStyle(fontSize: 40, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            _ResultInputField(
              editingController: editingController,
              onSubmitCallback: onSubmitCallback,
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultInputField extends StatelessWidget {
  final TextEditingController editingController;
  final VoidCallback onSubmitCallback;

  const _ResultInputField({
    required this.editingController,
    required this.onSubmitCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 140,
          child: TextField(
            controller: editingController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Result',
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            ),
            onSubmitted: (_) => onSubmitCallback(),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => onSubmitCallback(),
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
