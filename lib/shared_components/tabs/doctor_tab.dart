import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorTab extends StatelessWidget {
  const DoctorTab({super.key});

  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: const DoctorTab());
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> appointment =
        FirebaseFirestore.instance.collection('users').snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: appointment,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs.map((e) {
                Map<String, dynamic> data = e.data as Map<String, dynamic>;

                return ListTile(
                    title: Text(data['Firstname']),
                    subtitle: Text(data['lastname']),
                    trailing: const Text('Princes Marina Hospital'));
              }).toList(),
            );
          }
          return const Center(child: Text('An error occured'));
        });
  }
}
