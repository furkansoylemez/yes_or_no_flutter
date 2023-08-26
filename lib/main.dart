import 'package:flutter/material.dart';
import 'package:yes_or_no/app/app.dart';
import 'package:yes_or_no/injection_container.dart' as di;

void main() {
  di.init();
  runApp(const YesOrNoApp());
}
