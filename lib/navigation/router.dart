import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../managers/managers.dart';
import 'navigation.dart';

GoRouter router = GoRouter(
  routes: [Routes.login, Routes.home, Routes.register, Routes.doctorPage],
  refreshListenable: appStateManager,
  redirect: (context, state) {
    //final authProvider = Provider.of<AppStateManager>(context);
    // if(authProvider.isLoggedIn){
    //   return Routes.home.path;
    // }
    return Routes.doctorPage.path;
  },
);
