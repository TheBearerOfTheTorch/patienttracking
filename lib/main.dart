import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  runApp(PatientTracking());
}

class PatientTracking extends StatelessWidget {
  PatientTracking({super.key});
  final _appStateManager = AppStateManager();
  final _fieldStateManager = FieldStateManager();
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      fieldsStateManager: _fieldStateManager,
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FieldStateManager>(
            create: (context) => _fieldStateManager),
        Provider<ChangeNotifier>(create: (context) => appStateManager),
        StreamProvider<User?>.value(
          value: _appStateManager.user,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'patienttracking',
        theme: AppThemeData.light(),
        home: Router(
          routerDelegate: _appRouter,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
