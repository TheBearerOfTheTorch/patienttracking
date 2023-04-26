import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: const Profile());
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text('Show Appointments',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUser!.uid)
                      .collection('profile')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Theres an unexpected error'),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      children: snapshot.data!.docs.map((e) {
                        Map<String, dynamic> data =
                            e.data() as Map<String, dynamic>;

                        return ListTile(
                          title: Column(children: [
                            const Text('Your profile',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const Text('User name: '),
                                Text(data['name']),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text('Profession: '),
                                Text(data['profession']),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text('Hospital: '),
                                Text(data['nospital']),
                              ],
                            ),
                          ]),
                        );
                      }).toList(),
                    );
                  }),
            ],
          ),
        ));
  }
}
