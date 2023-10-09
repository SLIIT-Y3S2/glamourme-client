import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black,
      elevation: 30,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.calendar_month),
          label: 'Appointments',
        ),
        NavigationDestination(
          icon: Icon(Icons.cut_sharp),
          label: 'Salons',
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
