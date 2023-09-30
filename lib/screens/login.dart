import 'package:flutter/material.dart';
import 'package:flutter_app/screens/payment_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PaymentScreen()));
          },
          child: Text('Go to payment'),
        ));
  }
}
