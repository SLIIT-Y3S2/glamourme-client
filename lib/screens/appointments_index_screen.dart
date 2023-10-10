import 'package:flutter/material.dart';

class AppointmentIndexScreen extends StatelessWidget {
  const AppointmentIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Todo: Seperate UI into widgets
    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      body: const Center(
        child: Text('Appointments Screen'),
      ),
    );
  }
}
