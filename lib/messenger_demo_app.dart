import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger_demo/router/router.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MessengerDemoApp extends StatefulWidget {
  const MessengerDemoApp({super.key});

  @override
  State<MessengerDemoApp> createState() => _MessengerDemoAppState();
}

class _MessengerDemoAppState extends State<MessengerDemoApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MessengerDemo',
      themeMode: ThemeMode.dark,
      routerConfig: _appRouter.config(
        navigatorObservers: () => [
          TalkerRouteObserver(GetIt.I<Talker>()),
        ],
      ),
    );
  }
}
