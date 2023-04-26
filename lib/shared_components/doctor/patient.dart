import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Patient extends StatelessWidget {
  const Patient({super.key});

  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: const Patient());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text('Show Patients',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('patient')
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
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                      title: const Text('Patient details'),
                                      content: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text('Doctor name: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(data['doctorName'])
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: [
                                              const Text('Doctor Id: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(data['doctorId'])
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: [
                                              const Text('Treatment: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(data['treatment'])
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: [
                                              const Text(
                                                'Last treatment: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(data['date']),
                                            ],
                                          ),
                                        ],
                                      ));
                                }));
                          },
                          title: Text(data['Treatment']),
                          subtitle: Text(data['date']),
                        );
                      }).toList(),
                    );
                  }),
            ],
          ),
        ));
  }
}
