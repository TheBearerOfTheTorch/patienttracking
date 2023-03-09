import 'package:go_router/go_router.dart';

import '../managers/managers.dart';
import 'navigation.dart';

GoRouter router = GoRouter(
  initialLocation: Routes.splash.path,
  routes: [Routes.splash, Routes.login, Routes.home],
  refreshListenable: appStateManager,
  redirect: (context, state) =>
      GoRouterRedirector.instance.redirect(state, appStateManager),
);

class GoRouterRedirector {
  const GoRouterRedirector(this._redirects);
  final List<Redirect> _redirects;

  static GoRouterRedirector get instance {
    return GoRouterRedirector([
      UninitializedRedirect(),
      OnInitializationRedirect(),
      LoggedInRedirect(),
      UpdateHomeTabRedirect(),
      LoggedOutRedirect()
    ]);
  }

  ///
  ///checks current location [Uri] and also gets the uri return from
  ///[_redirects]
  ///
  String? redirect(GoRouterState state, AppStateManager manager) {
    final current = Uri(path: state.subloc, queryParameters: state.queryParams);
    for (final redirect in _redirects) {
      //redirect take place?
      if (redirect.predicate(state, manager)) {
        //[getNewUri]
        final uri = redirect.getNewUri(state, manager);
        //ensure null safety
        if (uri != null) {
          final uriString = uri.toString();

          //compare [current] to [uriString]
          if (uriString == current.toString()) {
            //since its the same uri no need to redirect
            return null;
          }

          //return new uriString
          return uriString;
        }
      }
    }

    //
    //return null and no redirects to take place
    //
    return null;
  }
}

abstract class Redirect {
  /// Determines whether this redirection should take place.
  bool predicate(GoRouterState state, AppStateManager manager);

  /// Returns an optional `Uri` instance if there is a redirect. This
  /// can return Null because `predicate` may return true if it knows there is
  /// zero chance any future redirect should be checked. For example, if the
  /// app is not initialized, you may know that your only possible redirect is
  /// *to* the splash screen. However, if you are already there, [getNewUri]
  /// will return null.
  Uri? getNewUri(GoRouterState state, AppStateManager manager);
}

class UninitializedRedirect extends Redirect {
  ///
  ///checking if the application is initialized
  ///
  @override
  bool predicate(GoRouterState state, AppStateManager manager) =>
      !appStateManager.isInitialized;

  ///
  ///get uri when the application is not initialized yet with
  ///query parameters
  ///
  @override
  Uri? getNewUri(GoRouterState state, AppStateManager manager) {
    if (state.subloc == Routes.splash.path) {
      return null;
    }

    final queryParams = Map<String, String>.from(state.queryParams);
    queryParams['next'] = state.subloc;

    return Uri(path: Routes.splash.path, queryParameters: queryParams);
  }
}

///
///This class will be called when the app has been initialized depending
///whether the user is logged in or not, it will return [Routes.login.path]
/// or [Routes.home.path]
///
class OnInitializationRedirect extends Redirect {
  ///app initialized?
  @override
  bool predicate(GoRouterState state, AppStateManager manager) =>
      manager.isInitialized && state.subloc == Routes.splash.path;

  ///determine if the user has logged in or redirect to [Routes.login.path]
  @override
  Uri? getNewUri(GoRouterState state, AppStateManager manager) {
    final queryParams = Map<String, String>.from(state.queryParams);

    String next = Routes.home.path;
    if (queryParams.containsKey('next')) {
      //grab copy of upcoming location
      next = queryParams.remove('next')!;
      final uri = Uri(path: next, queryParameters: queryParams);

      // See if the upcoming location is the home page and mentions a tab, and
      // if so, set that tab in our manager.
      if (uri.path == Routes.home.path &&
          uri.queryParameters.containsKey('tab')) {
        appStateManager.silentlySetTab(int.parse(uri.queryParameters['tab']!));
      }
      next = uri.path;
    }

    //home or login
    if (manager.isLoggedIn) {
      return Uri(path: next, queryParameters: queryParams);
    } else {
      queryParams['next'] = next;
      return Uri(
        path: Routes.login.path,
        queryParameters: queryParams,
      );
    }
  }
}

class LoggedInRedirect extends Redirect {
  ///loggedin and on the login page
  @override
  bool predicate(GoRouterState state, AppStateManager manager) =>
      manager.isLoggedIn && state.subloc == Routes.login.path;

  ///return [getNewUri] path [Routes.home.path]
  @override
  Uri? getNewUri(GoRouterState state, AppStateManager manager) {
    Map<String, String> queryParams = <String, String>{...state.queryParams};
    String next = queryParams.remove('next') ?? Routes.home.path;
    return Uri(path: next, queryParameters: queryParams);
  }
}

///
///Updating home page with tabs
///
class UpdateHomeTabRedirect extends Redirect {
  ///we should be at [Routes.home.path]
  @override
  bool predicate(GoRouterState state, AppStateManager manager) =>
      state.subloc == Routes.home.path;

  ///
  @override
  Uri? getNewUri(GoRouterState state, AppStateManager manager) {
    if (manager.selectedTab.toString() != state.queryParams['tab']) {
      final queryParams = Map<String, String>.from(state.queryParams);
      queryParams['tab'] = appStateManager.selectedTab.toString();
      return Uri(
        path: state.subloc,
        queryParameters: queryParams,
      );
    }
    return null;
  }
}

///
///When user have logged out
///
class LoggedOutRedirect extends Redirect {
  @override
  bool predicate(GoRouterState state, AppStateManager manager) =>
      manager.isInitialized &&
      (!manager.isLoggedIn && state.subloc != Routes.login.path);

  @override
  Uri? getNewUri(GoRouterState state, AppStateManager manager) =>
      Uri(path: Routes.login.path);
}
