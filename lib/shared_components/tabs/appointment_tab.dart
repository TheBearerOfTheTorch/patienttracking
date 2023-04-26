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
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text('Your appointments'),
        ),
        const SizedBox(height: 25),
        StreamBuilder<QuerySnapshot>(
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
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Appointments details'),
                                  content: Column(children: [
                                    Row(
                                      children: [
                                        const Text('Doctor name: '),
                                        Text(data['doctorName']),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Text('Appointment time: '),
                                        Text(data['time']),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Text('Appointment date: '),
                                        Text(data['date']),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Text('Appointment for: '),
                                        Text(data['meetingFor']),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ]),
                                );
                              });
                        },
                        title: Text(data['time']),
                        subtitle: Text(data['date']),
                        trailing: data['appointmentUpdate'] == 'true'
                            ? const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.green,
                                ),
                              )
                            : data['appointmentUpdate'] == 'false'
                                ? const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                    ),
                                  )
                                : const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                    ),
                                  ));
                  }).toList(),
                );
              }
              return const Center(child: Text('An error occured'));
            }),
      ],
    );
  }
}
