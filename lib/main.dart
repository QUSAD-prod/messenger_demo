import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:messenger_demo/core/strings/hive_strings.dart';
import 'package:messenger_demo/firebase_options.dart';
import 'package:messenger_demo/messenger_demo_app.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

bool shouldUseFirebaseEmulator = false;

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final talker = TalkerFlutter.init();
    GetIt.I.registerSingleton(talker);
    GetIt.I<Talker>().debug('Talker started...');

    await Hive.initFlutter();
    await Hive.openBox<Map<String, dynamic>>(HiveStrings.settingsBoxName);

    final FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    GetIt.I.registerSingleton(firebaseApp);
    final FirebaseAuth firebaseAuth = FirebaseAuth.instanceFor(app: GetIt.I<FirebaseApp>());
    GetIt.I.registerSingleton(firebaseAuth);

    if (shouldUseFirebaseEmulator) {
      await GetIt.I<FirebaseAuth>().useAuthEmulator('localhost', 9099);
    }

    Bloc.observer = TalkerBlocObserver(
      talker: talker,
      settings: const TalkerBlocLoggerSettings(),
    );

    FlutterError.onError = (details) {
      GetIt.I<Talker>().handle(details.exception, details.stack);
    };

    runApp(const MessengerDemoApp());
  }, (error, stackTrace) {
    GetIt.I<Talker>().handle(error, stackTrace);
  });
}
