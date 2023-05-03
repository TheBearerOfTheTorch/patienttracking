import 'package:go_router/go_router.dart';

import '../managers/managers.dart';
import 'navigation.dart';

GoRouter router = GoRouter(
  routes: [
    Routes.login,
    Routes.wrapper,
    Routes.home,
    Routes.register,
    Routes.doctorPage
  ],
  refreshListenable: appStateManager,
  redirect: (context, state) {
    // final authProvider = Provider.of<AppStateManager>(context);
    // if(authProvider.isLoggedIn){
    //   return Routes.wrapper.path;
    // }
    return Routes.login.path;
  },
);
