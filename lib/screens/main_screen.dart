import 'package:flutter/material.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/screens/appointments_index_screen.dart';
import 'package:flutter_app/screens/home_index_screen.dart';
import 'package:flutter_app/screens/profile_index_screen.dart';
import 'package:flutter_app/screens/salons_index_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            label: AppLocalizations.of(context)!.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_month_outlined),
            selectedIcon: const Icon(Icons.calendar_month),
            label: AppLocalizations.of(context)!.appointments,
          ),
          NavigationDestination(
            icon: const Icon(Icons.cut_sharp),
            label: AppLocalizations.of(context)!.salons,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outlined),
            selectedIcon: const Icon(Icons.person),
            label: AppLocalizations.of(context)!.profile,
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
