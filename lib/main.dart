import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/firebase_options.dart';
import 'package:flutter_app/glamourme_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logging configuration that logs all messages via print
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.loggerName} : ${record.level.name} ===> ${record.message}');
  });

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GlamourMeApp());
}
