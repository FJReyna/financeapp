import 'package:finance/core/app.dart';
import 'package:finance/core/dependency_injection.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const App());
}
