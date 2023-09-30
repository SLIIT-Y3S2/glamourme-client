import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/language_selection.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;
Future<void> main() async {
  // Initialize logging configuration that logs all messages via print
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.loggerName} : ${record.level.name} ===> ${record.message}');
  });

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1); //if already shown -> 1 else 0
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GlamourMe',
        theme: ThemeData().copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(kSeedColor),
            primary: Color(kPrimaryColor),
          ),
          textTheme: GoogleFonts.dmSansTextTheme(),
          useMaterial3: true,
        ),
        home: initScreen == 0 || initScreen == null
            ? const LanguageSelectionScreen()
            : const LoginScreen());
  }
}
