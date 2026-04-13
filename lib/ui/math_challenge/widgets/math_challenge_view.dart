import 'package:flutter/material.dart';
import 'package:hot_potato/ui/core/ui/animations/animated_entry_wrapper.dart';
import 'package:hot_potato/ui/core/ui/animations/animated_content_change.dart';

class MathChallengeView extends StatefulWidget {
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
  State<MathChallengeView> createState() => _MathChallengeViewState();
}

class _MathChallengeViewState extends State<MathChallengeView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Card(
        color: theme.colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.mathChallenge.isEmpty ? '? + ?' : widget.mathChallenge,
                style: theme.textTheme.displayLarge?.copyWith(
                  color: theme.colorScheme.onSecondaryContainer,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              _ResultInputField(
                editingController: widget.editingController,
                onSubmitCallback: widget.onSubmitCallback,
              ),
            ],
          ),
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
