import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/location/location_bloc.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/screens/appointments_index_screen.dart';
import 'package:flutter_app/screens/home_index_screen.dart';
import 'package:flutter_app/screens/profile_index_screen.dart';
import 'package:flutter_app/screens/salons_index_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  void initState() {
    super.initState();
    BlocProvider.of<LocationBloc>(context).add(const GetLocationEvent());
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
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Appointments',
          ),
          NavigationDestination(
            icon: Icon(Icons.cut_sharp),
            label: 'Salons',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
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
