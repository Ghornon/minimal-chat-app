import 'package:flutter/material.dart';
import 'package:minimal_chat_app/pages/login_page.dart';
import 'package:minimal_chat_app/themes/light_mode.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      theme: lightMode,
    );
  }
}
