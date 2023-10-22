import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/appointment/appointment_bloc.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/blocs/language/language_bloc.dart';
import 'package:flutter_app/blocs/location/location_bloc.dart';
import 'package:flutter_app/blocs/salons/salons_bloc.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/repositories/authentication/authentication_repository.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/main_screen.dart';
import 'package:flutter_app/screens/onboarding.dart';
import 'package:flutter_app/screens/signup_screen.dart';
import 'package:flutter_app/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class GlamourMeApp extends StatefulWidget {
  const GlamourMeApp({super.key});

  @override
  State<GlamourMeApp> createState() => _GlamourMeAppState();
}

class _GlamourMeAppState extends State<GlamourMeApp> {
  final List<Locale> _supportedLocales = const [
    Locale('en', 'US'),
    Locale('si'),
  ];
  final List<LocalizationsDelegate> _localizationDelegate = const [
    AppLocalizations.delegate, // Add this line
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  void _setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final token = await fcm.getToken();
    print('TOKEN========================================> $token');

    fcm.subscribeToTopic('appointments');
  }

  @override
  void initState() {
    super.initState();

    _setupPushNotifications();

    auth.FirebaseAuth.instance.authStateChanges().listen((user) async {
      _redirectToAuthenticate(user);
    });
  }

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

  @override
  Widget build(context) {
    final authRepository = AuthenticationRepository();
    final AuthenticationBloc authenticationBloc =
        AuthenticationBloc(authRepository);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => authRepository),
        RepositoryProvider(create: (context) => authenticationBloc),
        RepositoryProvider(create: (context) => SalonsBloc()),
        RepositoryProvider(create: (context) => AppointmentBloc()),
        RepositoryProvider(create: (context) => LocationBloc()),
        RepositoryProvider(create: (context) => LanguageBloc()),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            supportedLocales: _supportedLocales,
            locale:
                state is LanguageChanged ? state.locale : const Locale('en'),
            localizationsDelegates: _localizationDelegate,
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
        },
      ),
    );
  }
}

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
      return const SplashScreen();
  }
}
