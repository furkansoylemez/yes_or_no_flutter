import 'package:flutter/material.dart';
import 'package:yes_or_no/core/extensions/app_localizations.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        child: Text(context.l10n.submitButtonLabel),
      ),
    );
  }
}
