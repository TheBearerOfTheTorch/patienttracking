import 'package:flutter/material.dart';

class DoctorTab extends StatelessWidget {
  const DoctorTab({super.key});

  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: const DoctorTab());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("Doctor Tab"));
  }
}
