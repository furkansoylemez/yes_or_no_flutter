import 'package:flutter/material.dart';

class LastQuestion extends StatelessWidget {
  const LastQuestion({
    required this.lastQuestion,
    super.key,
  });

  final String lastQuestion;

  @override
  Widget build(BuildContext context) {
    return Text(
      lastQuestion,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}
