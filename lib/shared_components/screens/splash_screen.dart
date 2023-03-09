import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: const SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("Splash screen"));
  }
}
