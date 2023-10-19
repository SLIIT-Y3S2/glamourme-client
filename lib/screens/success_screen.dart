import 'package:flutter/material.dart';
import 'package:flutter_app/app_locale.dart';
import 'package:flutter_localization/flutter_localization.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200, // Adjust the width as needed
          height: 200, // Adjust the height as needed
          child: Center(
              child: Column(children: [
            const SizedBox(
              height: 120,
            ),
            Text(
              AppLocale.success.getString(context),
              style: const TextStyle(
                color: Color(0xFF1C1C28),
                fontSize: 19,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                height: 0,
                letterSpacing: -0.38,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              AppLocale.verificationIsDone.getString(context),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF8E90A5),
                fontSize: 15,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: 0.50,
              ),
            ),
          ])),
        ),
      ),
    );
  }
}
