import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppointmentIndexScreen extends StatelessWidget {
  const AppointmentIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Todo: Seperate UI into widgets
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appointments)),
      body: const Center(
        child: Text('Appointments Screen'),
      ),
    );
  }
}
