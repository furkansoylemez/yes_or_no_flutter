import 'package:flutter/material.dart';

class LastAnswer extends StatelessWidget {
  const LastAnswer({
    required this.imageUrl,
    super.key,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl ?? '');
  }
}
