import 'package:flutter/material.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: const HistoryTab());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("History Tab"));
  }
}
