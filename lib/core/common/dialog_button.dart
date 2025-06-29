import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimaryAction;

  const DialogButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimaryAction = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: isPrimaryAction
          ? TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            )
          : TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onSurface,
            ),
      child: Text(text),
    );
  }
}
