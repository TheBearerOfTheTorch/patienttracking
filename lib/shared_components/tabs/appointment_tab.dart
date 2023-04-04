import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppointmentTab extends StatelessWidget {
  const AppointmentTab({super.key});

  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: const AppointmentTab());
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> appointment =
        FirebaseFirestore.instance.collection('appointment').snapshots();
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: appointment,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!.docs.map((e) {
                    Map<String, dynamic> data = e.data as Map<String, dynamic>;

                    return ListTile(
                        leading: Text(data['time']),
                        title: Column(children: [
                          Text(data['appointment_type']),
                          Text(data['doctor_name']),
                        ]),
                        trailing: Text(data['date']));
                  }).toList(),
                );
              }
              return const Center(child: Text('An error occured'));
            }));
  }
}
