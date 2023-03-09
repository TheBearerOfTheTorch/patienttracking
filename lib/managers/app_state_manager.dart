import 'package:flutter/material.dart';

class Tabs {
  static final int home = 0;
  static final int doctors = 1;
  static final int history = 2;
  static final int appointments = 3;
}

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;
  bool _loggedIn = false;
  bool _darkmode = false;
  int _selectedTab = Tabs.home;

  ///
  ///getters
  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get darkmode => _darkmode;
  int get selectedTab => _selectedTab;

  ///
  ///setters
  void initializeApp() {
    _initialized = true;
    notifyListeners();
  }

  void loggedIn() {
    _loggedIn = true;
    notifyListeners();
  }

  void darkMode() {
    _darkmode = true;
    notifyListeners();
  }

  void goToTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  void silentlySetTab(index) {
    _selectedTab = index;
  }
}

final appStateManager = AppStateManager();
