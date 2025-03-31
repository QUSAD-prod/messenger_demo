import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:messenger_demo/core/strings/hive_strings.dart';
import 'package:messenger_demo/core/theme/app_theme.dart';
import 'package:messenger_demo/router/app_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MessengerDemoApp extends StatefulWidget {
  const MessengerDemoApp({super.key});

  @override
  State<MessengerDemoApp> createState() => _MessengerDemoAppState();
}

class _MessengerDemoAppState extends State<MessengerDemoApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter();
    GetIt.I.registerSingleton(_appRouter);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(HiveStrings.settingsBoxName).listenable(),
      builder: (context, box, widget) {
        return MaterialApp.router(
          title: 'MessengerDemo',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: AppTheme.getTheme(
            box.get(HiveStrings.themePath, defaultValue: HiveStrings.themeSystem),
          ),
          routerConfig: _appRouter.config(
            navigatorObservers: () => [
              TalkerRouteObserver(GetIt.I<Talker>()),
            ],
          ),
        );
      },
    );
  }
}
