import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/screens/appointments_screen.dart';
import 'package:flutter_app/screens/payment_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _signOut(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(const SignOutEvent());
  }

  @override
  Widget build(BuildContext context) {
    // Bottom navigation bar
    NavigationBar bottomNavigationBar = NavigationBar(
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

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {},
      child: Scaffold(
        bottomNavigationBar: bottomNavigationBar,
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PaymentScreen()));
              },
              child: Text('Go to payment'),
            ),
            ElevatedButton(
              onPressed: () {
                _signOut(context);
              },
              child: Text('Sign out'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AppointmentScreen()));
              },
              child: Text('Go to appointments'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AppointmentScreen()));
                },
                child: Text('Appointments')),
          ],
        ),
      ),
    );
  }
}
