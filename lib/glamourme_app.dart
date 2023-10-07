import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/repositories/authentication/authentication_repository.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:is_first_run/is_first_run.dart';

class GlamourMeApp extends StatefulWidget {
  const GlamourMeApp({Key? key}) : super(key: key);

  @override
  State<GlamourMeApp> createState() => _GlamourMeAppState();
}

class _GlamourMeAppState extends State<GlamourMeApp> {
  @override
  void initState() {
    super.initState();
    //Todo listen to authentication state
  }

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthenticationRepository();

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
      home: const LoginScreen(),
    );

    return MultiRepositoryProvider(providers: [
      RepositoryProvider(create: (context) => authRepository),
      RepositoryProvider(
          create: (context) => AuthenticationBloc(authRepository))
    ], child: app);
  }
}
