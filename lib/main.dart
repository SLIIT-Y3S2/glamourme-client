import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/counter/counter_bloc.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/onboarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(kSeedColor)),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: const OnboardingScreen(),
      ),
    );
  }
}
