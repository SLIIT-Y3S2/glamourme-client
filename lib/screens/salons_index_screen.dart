import 'package:flutter/material.dart';
import 'package:flutter_app/globals.dart';

class SalonsIndexScreen extends StatelessWidget {
  const SalonsIndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: salonsNavigatorKey,
      appBar: AppBar(title: const Text('Salons')),
      body: const Center(
        child: Text('Salons Screen'),
      ),
    );
  }
}
