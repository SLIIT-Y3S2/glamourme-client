import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/blocs/onboarding/onboarding_bloc.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/repositories/authentication/authentication_repository.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/onboarding.dart';
import 'package:flutter_app/screens/signup_screen.dart';
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

  // Used to check if the app is running for the first time
  void _checkFirstRun() async {
    bool ifr = await IsFirstRun.isFirstRun().then((value) => value);
    setState(() {
      _isFirstRun = ifr;
    });
  }

  // Used to redirect to the appropriate screen
  void _redirectToAuthenticate(auth.User? user) {
    print(user);
    if (user == null) {
      globalNavigatorKey.currentState!.pushReplacementNamed('/login');
    } else {
      globalNavigatorKey.currentState!.pushReplacementNamed('/home');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkFirstRun();
    if (_isFirstRun) {
      globalNavigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        ),
      );
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
        navigatorKey: globalNavigatorKey,
        onGenerateRoute: getRouteSettings());

    return MultiRepositoryProvider(providers: [
      RepositoryProvider(create: (context) => authRepository),
      RepositoryProvider(create: (context) => OnboardingBloc()),
      RepositoryProvider(create: (context) => authenticationBloc)
    ], child: app);
  }
}

// Used to get the route settings
MaterialPageRoute Function(RouteSettings settings) getRouteSettings() {
  return (RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => _getPageRoutes(context, settings));
  };
}

// Used to get the page routes
_getPageRoutes(BuildContext context, RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return const OnBoardingScreen();
    case '/login':
      return const LoginScreen();
    case '/signup':
      return const SignupScreen();
    case '/home':
      return const HomeScreen();
    default:
      return const OnBoardingScreen();
  }
}
