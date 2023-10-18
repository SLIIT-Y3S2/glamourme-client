import 'package:flutter/material.dart';
import 'package:flutter_app/app_locale.dart';
import 'package:flutter_app/screens/onboarding.dart';
import 'package:flutter_localization/flutter_localization.dart';

class LanguageSelectionScreen extends StatelessWidget {
  LanguageSelectionScreen({super.key});

// For localizations
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  Widget build(BuildContext context) {
    void navigateToOnBoarding() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            //Background Image
            Image.asset(
              'assets/images/image 1.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            //Background Tint
            Container(
              color: Colors.black54,
            ),
            //Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                Text(
                  'Welcome to GlamourMe',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Text(
                  AppLocale.languageDescription.getString(context),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: navigateToOnBoarding,
                      child: const Text('English'),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        //Translate the app to sinhala
                        _localization.translate('si');
                        navigateToOnBoarding();
                      },
                      child: const Text('සිංහල'),
                    ),
                  ],
                ),
                const SizedBox(height: 50)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
