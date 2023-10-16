import 'package:flutter/material.dart';
import 'package:flutter_app/screens/mobile_number_screen.dart';
import 'package:flutter_app/screens/otp_screen.dart';
import 'package:flutter_app/screens/payment_screen.dart';
import 'package:flutter_app/screens/signup_screen.dart';
import 'package:flutter_app/screens/success_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Column(children: [
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PaymentScreen()));
                  },
                  child: Text('Go to payment')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignupScreen()));
                  },
                  child: Text('Signup')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MobileNumberScreen()));
                  },
                  child: const Text('Test Screen 2')),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const OtpScreen()));
                  },
                  child: const Text('OTP Screen')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SuccessScreen()));
                  },
                  child: const Text('SuccessScreen'))
            ],
          )
        ]));
  }
}
