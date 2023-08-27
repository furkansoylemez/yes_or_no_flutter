import 'package:flutter/material.dart';
import 'package:yes_or_no/core/extensions/app_localizations.dart';

class QuestionField extends StatelessWidget {
  const QuestionField({
    required this.controller,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(),
        hintText: context.l10n.questionFieldHint,
      ),
      onChanged: onChanged,
    );
  }
}
