import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PatientTracking());
}

class PatientTracking extends StatelessWidget {
  const PatientTracking({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'patienttracking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
