import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_theme_data.dart';
import 'firebase_options.dart';
import 'managers/managers.dart';
import 'navigation/navigation.dart';

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
    return MultiProvider(
      providers: [Provider<ChangeNotifier>(create: (_) => appStateManager)],
      child: MaterialApp.router(
        title: 'patienttracking',
        theme: AppThemeData.light(),
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('fr', 'CH'),
        ],
      ),
    );
  }
}
