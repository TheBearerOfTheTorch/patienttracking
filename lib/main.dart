import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_theme_data.dart';
import 'firebase_options.dart';
import 'managers/managers.dart';
import 'models/models.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(PatientTracking());
}

class PatientTracking extends StatelessWidget {
  PatientTracking({super.key});
  final _appStateManager = AppStateManager();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FieldStateManager>(
            create: (context) => FieldStateManager()),
        Provider<ChangeNotifier>(create: (context) => AppStateManager()),
        StreamProvider<User?>.value(
          value: _appStateManager.user,
          initialData: null,
        ),
      ],
      child: Material(
        child: MaterialApp(
          title: 'patienttracking',
          theme: AppThemeData.light(),
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ),
      ),
    );
  }
}
