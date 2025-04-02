import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:messenger_demo/core/models/settings_model.dart';
import 'package:messenger_demo/core/models/theme_mode_adapter.dart';
import 'package:messenger_demo/core/strings/hive_strings.dart';
import 'package:messenger_demo/firebase_options.dart';
import 'package:messenger_demo/messenger_demo_app.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

bool shouldUseFirebaseEmulator = false;

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final talker = TalkerFlutter.init();
    GetIt.I.registerSingleton(talker);
    GetIt.I<Talker>().debug('Talker started...');

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    await Hive.initFlutter();
    Hive.registerAdapter(SettingsModelAdapter());
    Hive.registerAdapter(ThemeModeAdapter());
    Box settingsBox = await Hive.openBox<SettingsModel>(HiveStrings.settingsBoxName);
    settingsBox.put(
      HiveStrings.settingsBoxKey,
      settingsBox.get(HiveStrings.settingsBoxKey, defaultValue: SettingsModel()).copyWith(
            appName: packageInfo.appName,
            packageName: packageInfo.packageName,
            version: packageInfo.version,
            buildNumber: packageInfo.buildNumber,
          ),
    );

    final FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final FirebaseAuth firebaseAuth = FirebaseAuth.instanceFor(app: firebaseApp);
    if (shouldUseFirebaseEmulator) {
      await firebaseAuth.useAuthEmulator('localhost', 9099);
    }
    GetIt.I.registerSingleton(firebaseApp);
    GetIt.I.registerSingleton(firebaseAuth);

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
