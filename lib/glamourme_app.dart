import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/blocs/onboarding/onboarding_bloc.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/repositories/authentication/authentication_repository.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/onboarding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:is_first_run/is_first_run.dart';

class GlamourMeApp extends StatefulWidget {
  const GlamourMeApp({super.key});

  @override
  State<GlamourMeApp> createState() => _GlamourMeAppState();
}

class _GlamourMeAppState extends State<GlamourMeApp> {
  bool _isFirstRun = false;
  Widget _widget = Container();

  // Used to check if the app is running for the first time
  void _checkFirstRun() async {
    bool ifr = await IsFirstRun.isFirstRun();
    setState(() {
      _isFirstRun = ifr;
    });
  }

  // Used to redirect to the appropriate screen
  void _redirectToAuthenticate(auth.User? user) {
    if (user == null) {
      _widget = const LoginScreen();
    } else {
      _widget = const HomeScreen();
    }
  }

  @override
  void initState() {
    super.initState();
    _checkFirstRun();

    if (_isFirstRun) {
      _widget = const OnBoardingScreen();
    } else {
      auth.FirebaseAuth.instance.authStateChanges().listen((user) async {
        _redirectToAuthenticate(user);
      });
    }
  }

  @override
  Widget build(context) {
    final authRepository = AuthenticationRepository();
    final AuthenticationBloc authenticationBloc =
        AuthenticationBloc(authRepository);

    ///Material App
    MaterialApp app = MaterialApp(
      title: 'GlamourMe',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(kSeedColor),
          primary: Color(kPrimaryColor),
        ),
        textTheme: GoogleFonts.dmSansTextTheme(),
        useMaterial3: true,
      ),
      home: _widget,
    );

    return MultiRepositoryProvider(providers: [
      RepositoryProvider(create: (context) => authRepository),
      RepositoryProvider(create: (context) => OnboardingBloc()),
      RepositoryProvider(create: (context) => authenticationBloc)
    ], child: app);
  }
}
