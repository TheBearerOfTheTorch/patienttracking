import '../shared_components/shared_components.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final home = GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return HomeScreen.page(key: state.pageKey);
      });
  static final splash = GoRoute(
      path: '/splash',
      pageBuilder: (context, state) {
        return SplashScreen.page(key: state.pageKey);
      });

  static final login = GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return LoginScreen.page(key: state.pageKey);
      });
}
