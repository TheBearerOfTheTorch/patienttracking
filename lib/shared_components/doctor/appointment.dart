import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/managers.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: const Appointment());
  }

  @override
  Widget build(BuildContext context) {
    final appStateManager = Provider.of<AppStateManager>(context);
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
                      .collection('appointment')
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
                                      title: const Text('Appointment details'),
                                      content: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text('Patient Name: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(data['patientName'])
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: [
                                              const Text('Patient Id: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(data['patientId'])
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: [
                                              const Text('Appointment date: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(data['date'])
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: [
                                              const Text(
                                                'Appointment time: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(data['time']),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: [
                                              const Text(
                                                'Meeting For: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(data['meetingFor']),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    await appStateManager
                                                        .updateAppointment(
                                                            appointmentUpdate:
                                                                true,
                                                            userId: data[
                                                                'patientId'],
                                                            appointmentId: data[
                                                                'appointmentId']);
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 3), () {
                                                      SnackBar snackBar =
                                                          const SnackBar(
                                                              content: Text(
                                                                  'You have updated appointment successfully'));

                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return snackBar;
                                                          });
                                                    });
                                                  },
                                                  child: const Text('Accept')),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    await appStateManager
                                                        .updateAppointment(
                                                            appointmentUpdate:
                                                                false,
                                                            userId: data[
                                                                'patientId'],
                                                            appointmentId: data[
                                                                'appointmentId']);

                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 3), () {
                                                      SnackBar snackBar =
                                                          const SnackBar(
                                                              content: Text(
                                                                  'You have updated appointment successfully'));

                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return snackBar;
                                                          });
                                                    });
                                                  },
                                                  child: const Text('cancel'))
                                            ],
                                          )
                                        ],
                                      ));
                                }));
                          },
                          title: Text(data['patientName']),
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
