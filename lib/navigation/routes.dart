import '../models/models.dart';
import '../shared_components/shared_components.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final home = GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return HomeScreen.page(key: state.pageKey);
      });
  static final wrapper = GoRoute(
      path: '/server',
      pageBuilder: (context, state) {
        return Wrapper.page(key: state.pageKey);
      });
  static final doctorPage = GoRoute(
      path: '/doctor',
      pageBuilder: (context, state) {
        return DoctorPage.page(key: state.pageKey);
      },
      routes: [
        GoRoute(
          path: 'appointment',
          pageBuilder: (context, state) {
            return Appointment.page();
          },
        ),
        GoRoute(
          path: 'patient',
          pageBuilder: (context, state) {
            return Patient.page();
          },
        ),
        GoRoute(
          path: 'profile',
          pageBuilder: (context, state) {
            return Profile.page();
          },
        ),
      ]);

  static final login = GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return LoginScreen.page(key: state.pageKey);
      });

  static final register = GoRoute(
      path: '/signup',
      pageBuilder: (context, state) {
        return SignupScreen.page(key: state.pageKey);
      });
}
