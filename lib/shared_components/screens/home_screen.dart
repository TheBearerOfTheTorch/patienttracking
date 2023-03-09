import 'package:flutter/material.dart';

import '../../managers/managers.dart';
import '../shared_components.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: HomeScreen());
  }

  ///
  ///Tabs list
  final List<Widget> tabs = [
    const HomeTab(),
    const DoctorTab(),
    const HistoryTab(),
    const AppointmentTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Text('leading'),
          title: const Text('Patient Tracking app'),
        ),
        body: IndexedStack(index: appStateManager.selectedTab, children: tabs),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: appStateManager.selectedTab,
          onTap: (index) => appStateManager.goToTab(index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home)),
            BottomNavigationBarItem(
                icon: Icon(Icons.access_alarm_outlined),
                activeIcon: Icon(Icons.access_alarm)),
            BottomNavigationBarItem(
                icon: Icon(Icons.history_outlined),
                activeIcon: Icon(Icons.history)),
            BottomNavigationBarItem(
                icon: Icon(Icons.app_shortcut_outlined),
                activeIcon: Icon(Icons.app_shortcut))
          ],
        ));
  }
}
