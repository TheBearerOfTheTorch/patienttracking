import 'package:flutter/material.dart';

class AppointmentTab extends StatelessWidget {
  const AppointmentTab({super.key});

  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: const AppointmentTab());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("Appointment Tab"));
  }
}
