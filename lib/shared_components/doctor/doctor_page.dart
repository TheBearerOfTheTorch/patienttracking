import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/navigation.dart';
import '../shared_components.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});
  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: const DoctorPage());
  }

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(),
        ),
        title: const ListTile(
          title: Text('Doctors full name'),
          subtitle: Text('Doctor proffesion'),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 8.0),
                  child: Text(
                    'Appointments',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                foregroundDecoration: const BoxDecoration(
                    border: BorderDirectional(start: BorderSide.none)),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Appointment()),
                            );
                            //GoRouter.of(context).go('/doctor/appointment');
                          },
                          icon: const Icon(Icons.meeting_room),
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('10',
                              style: TextStyle(color: Colors.white)),
                        )
                      ]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 8.0),
                  child: Text(
                    'Update patients',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Patient()),
                  );
                  //router.go('/doctor/patient');
                },
                label: const Text('Click here'),
                icon: const Icon(Icons.pages),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 8.0),
                  child: Text(
                    'Update profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  //router.go('/doctor/profile');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Profile()),
                  );
                },
                label: const Text('Click here'),
                icon: const Icon(Icons.pages),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
