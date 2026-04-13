import 'package:flutter/material.dart';

class ResultInputField extends StatelessWidget {
  final TextEditingController editingController;
  final FocusNode focusNode;
  final VoidCallback onSubmitCallback;

  const ResultInputField({
    super.key,
    required this.editingController,
    required this.focusNode,
    required this.onSubmitCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildAnswerInputField(context),
        const SizedBox(width: 12),
        _buildSubmitButton(context),
      ],
    );
  }

  Widget _buildAnswerInputField(BuildContext context) {
    return Container(
      width: 120,
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: editingController,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '???',
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
        onSubmitted: (_) => onSubmitCallback(),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onSubmitCallback,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          '✓',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
