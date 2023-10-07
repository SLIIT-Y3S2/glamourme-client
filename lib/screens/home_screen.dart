import 'package:flutter/material.dart';
import 'package:flutter_app/screens/appointments_screen.dart';
import 'package:flutter_app/screens/payment_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AppointmentScreen()));
            },
            child: Text('Appointments')),
      ],
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Row(children: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PaymentScreen()));
            },
            child: Text('Go to payment')),
      ]),
    );
  }
}
