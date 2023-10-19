import 'package:flutter/material.dart';
import 'package:flutter_app/app_locale.dart';
import 'package:flutter_localization/flutter_localization.dart';

class AppointmentIndexScreen extends StatelessWidget {
  const AppointmentIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Todo: Seperate UI into widgets
    return Scaffold(
      appBar: AppBar(title: Text(AppLocale.appointments.getString(context))),
      body: const Center(
        child: Text('Appointments Screen'),
      ),
    );
  }
}
