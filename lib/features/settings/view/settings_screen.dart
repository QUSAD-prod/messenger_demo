import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:messenger_demo/core/strings/hive_strings.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box(HiveStrings.settingsBoxName).listenable(),
        builder: (context, box, widget) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  _themeSwitch(context: context, box: box),
                  Divider(),
                  Text("Version: ${box.get(HiveStrings.versionPath)}"),
                  Text("Build: ${(box.get(HiveStrings.buildNumberPath) == "" ? "-" : box.get(HiveStrings.buildNumberPath))}"),
                  Text("by QUSAD.prod"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _themeSwitch({required BuildContext context, required Box box}) {
    String currentValue = box.get(HiveStrings.themePath, defaultValue: HiveStrings.themeSystem);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0),
          child: Text("Theme mode"),
        ),
        RadioListTile(
          title: Text("Light"),
          value: HiveStrings.themeLight,
          groupValue: currentValue,
          onChanged: (value) => box.put(HiveStrings.themePath, HiveStrings.themeLight),
        ),
        RadioListTile(
          title: Text("Dark"),
          value: HiveStrings.themeDark,
          groupValue: currentValue,
          onChanged: (value) => box.put(HiveStrings.themePath, HiveStrings.themeDark),
        ),
        RadioListTile(
          title: Text("System"),
          value: HiveStrings.themeSystem,
          groupValue: currentValue,
          onChanged: (value) => box.put(HiveStrings.themePath, HiveStrings.themeSystem),
        ),
      ],
    );
  }
}
