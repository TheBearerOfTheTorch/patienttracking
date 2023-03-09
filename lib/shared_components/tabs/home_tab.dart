import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: const HomeTab());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("Home Tab"));
  }
}
