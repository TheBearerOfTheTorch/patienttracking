import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("Login screen"));
  }
}
