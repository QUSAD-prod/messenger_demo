import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger_demo/router/app_router.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Чаты"),
        actions: [
          IconButton(
            onPressed: () => GetIt.I<AppRouter>().push(const SettingsRoute()),
            tooltip: "Настройки",
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
