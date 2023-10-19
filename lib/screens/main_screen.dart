import 'package:flutter/material.dart';
import 'package:flutter_app/app_locale.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/screens/appointments_index_screen.dart';
import 'package:flutter_app/screens/home_index_screen.dart';
import 'package:flutter_app/screens/profile_index_screen.dart';
import 'package:flutter_app/screens/salons_index_screen.dart';
import 'package:flutter_localization/flutter_localization.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainScreen> {
  final _pages = [
    const HomeIndexScreen(),
    const AppointmentIndexScreen(),
    const SalonsIndexScreen(),
    const ProfileIndexScreen(),
  ];
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    homeNavigatorKey,
    appointmetNavigatorKey,
    salonsNavigatorKey,
    profileNavigatorKey,
  ];

  // final Map<int, GlobalKey> _navigatorKeys = {
  //   0: homeNavigatorKey,
  //   1: appointmetNavigatorKey,
  //   2: salonsNavigatorKey,
  //   3: profileNavigatorKey,
  // };

  int _currentIndex = 0;

  void _onDestinationSelected(int index) {
    if (_currentIndex == index) {
      var state = _navigatorKeys[index].currentState;
      if (state != null) {
        _navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
      }
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        key: bottomNavigationKey,
        animationDuration: const Duration(seconds: 1),
        selectedIndex: _currentIndex,
        onDestinationSelected: _onDestinationSelected,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 30,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: AppLocale.home.getString(context),
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_month_outlined),
            selectedIcon: const Icon(Icons.calendar_month),
            label: AppLocale.appointments.getString(context),
          ),
          NavigationDestination(
            icon: const Icon(Icons.cut_sharp),
            label: AppLocale.salons.getString(context),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outlined),
            selectedIcon: const Icon(Icons.person),
            label: AppLocale.profile.getString(context),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }
}
