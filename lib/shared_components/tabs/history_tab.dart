import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: const HistoryTab());
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final Stream<QuerySnapshot> appointment = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('history')
        .snapshots();
    return const Center(
        child: Text(
      'Theres no Medical history for you',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ));
  }
}
