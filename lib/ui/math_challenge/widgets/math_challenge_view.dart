import 'package:flutter/material.dart';
import 'math_challenge_parser.dart';
import 'result_input_field.dart';

class MathChallengeView extends StatefulWidget {
  final String mathChallenge;
  final TextEditingController editingController;
  final FocusNode focusNode;
  final VoidCallback onSubmitCallback;

  const MathChallengeView({
    super.key,
    required this.mathChallenge,
    required this.editingController,
    required this.focusNode,
    required this.onSubmitCallback,
  });

  @override
  State<MathChallengeView> createState() => _MathChallengeViewState();
}

class _MathChallengeViewState extends State<MathChallengeView> {
  final _parser = MathChallengeParser();

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
              _parser.buildChallengeText(widget.mathChallenge, theme),
              const SizedBox(height: 12),
              ResultInputField(
                editingController: widget.editingController,
                focusNode: widget.focusNode,
                onSubmitCallback: widget.onSubmitCallback,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
