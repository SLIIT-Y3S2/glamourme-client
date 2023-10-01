import 'package:flutter/material.dart';
import 'package:flutter_app/screens/payment_screen.dart';
import 'package:flutter_app/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Row(children: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PaymentScreen()));
            },
            child: Text('Go to payment')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignupScreen()));
            },
            child: Text('Signup'))
      ]),
    );
  }
}
