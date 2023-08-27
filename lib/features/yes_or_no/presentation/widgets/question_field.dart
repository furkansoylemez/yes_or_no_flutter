import 'package:flutter/material.dart';

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
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(),
        hintText: 'Ask a question',
      ),
      onChanged: onChanged,
    );
  }
}
