import 'package:flutter/material.dart';

import '../managers/managers.dart';
import '../shared_components/shared_components.dart';
import 'navigation.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  // 2
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  // state managers
  final AppStateManager appStateManager;
  final FieldStateManager fieldsStateManager;
  // final AuthenticationStateManager authenticationStateManager;
  // final ErrorStateManager errorStateManager;
  // final LoadingStateManager loadingStateManager;
  // final KeyboardStateManager keyboardStateManager;

  AppRouter({
    required this.appStateManager,
    required this.fieldsStateManager,
    // required this.authenticationStateManager,
    // required this.errorStateManager,
    // required this.loadingStateManager,
    // required this.keyboardStateManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    fieldsStateManager.addListener(notifyListeners);
    // authenticationStateManager.addListener(notifyListeners);
    // errorStateManager.addListener(notifyListeners);
    // loadingStateManager.addListener(notifyListeners);
    // keyboardStateManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    fieldsStateManager.removeListener(notifyListeners);
    // authenticationStateManager.removeListener(notifyListeners);
    // errorStateManager.removeListener(notifyListeners);
    // loadingStateManager.removeListener(notifyListeners);
    // loadingStateManager.removeListener(notifyListeners);
    super.dispose();
  }

  // 5
  @override
  Widget build(BuildContext context) {
    // 6
    return Navigator(
      // 7
      key: navigatorKey,
      onPopPage: _handlePopPage,

      pages: [
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
          Layout.page(),
        if (appStateManager.isLoggedIn) HomeScreen.page(),
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    // 3
    if (!route.didPop(result)) {
      return false;
    }

    // poping and logging out
    if (route.settings.name == Routes.home) {
      appStateManager.logout();
    }
    return true;
  }

  // 9
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
