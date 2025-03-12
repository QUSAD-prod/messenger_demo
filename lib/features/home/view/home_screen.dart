import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:messenger_demo/router/router.dart';

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
        actions: [
          IconButton(
            onPressed: () => AutoRouter.of(context).push(const SettingsRoute()),
            tooltip: "Settings",
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
