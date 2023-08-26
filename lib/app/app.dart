import 'package:flutter/material.dart';
import 'package:yes_or_no/features/yes_or_no/presentation/pages/yes_or_no_page.dart';

class YesOrNoApp extends StatelessWidget {
  const YesOrNoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.purple),
      home: const YesOrNoPage(),
    );
  }
}
