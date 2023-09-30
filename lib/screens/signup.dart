import 'package:flutter/material.dart';
import 'package:flutter_app/screens/payment_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Signup'),
        ),
        body: Center(
            child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PaymentScreen()));
          },
          child: Text('PAYMENT'),
        )));
  }
}
