import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/blocs/onboarding/onboarding_bloc.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/repositories/authentication/authentication_repository.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/onboarding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:is_first_run/is_first_run.dart';

class GlamourMeApp extends StatefulWidget {
  const GlamourMeApp({Key? key}) : super(key: key);

  @override
  State<GlamourMeApp> createState() => _GlamourMeAppState();
}

class _GlamourMeAppState extends State<GlamourMeApp> {
  bool _isFirstRun = false;

  void _checkFirstRun() async {
    bool ifr = await IsFirstRun.isFirstRun();
    setState(() {
      _isFirstRun = ifr;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkFirstRun();
    //Todo listen to authentication state
  }

  @override
  Widget build(BuildContext context) {
    var authRepository = AuthenticationRepository();

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
      home: _isFirstRun ? const OnBoardingScreen() : const LoginScreen(),
    );

    return MultiRepositoryProvider(providers: [
      RepositoryProvider(create: (context) => authRepository),
      RepositoryProvider(create: (context) => OnboardingBloc()),
      RepositoryProvider(
          create: (context) => AuthenticationBloc(authRepository))
    ], child: app);
  }
}
