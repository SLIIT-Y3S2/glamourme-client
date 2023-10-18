import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/appointment/appointment_bloc.dart';
import 'package:flutter_app/app_locale.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/blocs/salons/salons_bloc.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/repositories/authentication/authentication_repository.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/main_screen.dart';
import 'package:flutter_app/screens/onboarding.dart';
import 'package:flutter_app/screens/signup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:flutter_localization/flutter_localization.dart';

class GlamourMeApp extends StatefulWidget {
  const GlamourMeApp({super.key});

  @override
  State<GlamourMeApp> createState() => _GlamourMeAppState();
}

class _GlamourMeAppState extends State<GlamourMeApp> {
  // Used to redirect to the appropriate screen
  void _redirectToAuthenticate(auth.User? user) async {
    if (user == null) {
      bool ifr = await IsFirstRun.isFirstRun();

      if (ifr) {
        globalNavigatorKey.currentState!.pushReplacementNamed('/onboarding');
      } else {
        globalNavigatorKey.currentState!.pushReplacementNamed('/login');
      }
    } else {
      globalNavigatorKey.currentState!.pushReplacementNamed('/main');
    }
  }

// For localizations
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  void initState() {
    _localization.init(
      mapLocales: [
        const MapLocale(
          'en',
          AppLocale.EN,
        ),
        const MapLocale(
          'si',
          AppLocale.SI,
        )
      ],
      initLanguageCode: 'en',
    );
    _localization.onTranslatedLanguage = _onTranslatedLanguage;

    super.initState();
    auth.FirebaseAuth.instance.authStateChanges().listen((user) async {
      _redirectToAuthenticate(user);
    });
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(context) {
    final authRepository = AuthenticationRepository();
    final AuthenticationBloc authenticationBloc =
        AuthenticationBloc(authRepository);

    ///Material App
    MaterialApp app = MaterialApp(
      supportedLocales: _localization.supportedLocales,
      localizationsDelegates: _localization.localizationsDelegates,
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
      onGenerateRoute: getRouteSettings(),
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => authRepository),
        RepositoryProvider(create: (context) => authenticationBloc),
        RepositoryProvider(create: (context) => SalonsBloc()),
        RepositoryProvider(create: (context) => AppointmentBloc()),
      ],
      child: app,
    );
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
    case '/login':
      return const LoginScreen();
    case '/signup':
      return const SignupScreen();
    case '/main':
      return const MainScreen();
    case '/onboarding':
      return const OnBoardingScreen();
    default:
      //Todo add splash screen
      return const OnBoardingScreen();
  }
}
