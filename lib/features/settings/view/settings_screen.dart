import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:messenger_demo/core/strings/hive_strings.dart';
import 'package:messenger_demo/router/router.dart';

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
        title: Text('Настройки'),
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
                  _devGroup(),
                  Divider(),
                  Text("Версия приложения: ${box.get(HiveStrings.versionPath)}"),
                  Text("Номер сборки: ${(box.get(HiveStrings.buildNumberPath) == "" ? "-" : box.get(HiveStrings.buildNumberPath))}"),
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
          child: Text("Тема"),
        ),
        RadioListTile(
          title: Text("Светлая"),
          value: HiveStrings.themeLight,
          groupValue: currentValue,
          onChanged: (value) => box.put(HiveStrings.themePath, HiveStrings.themeLight),
        ),
        RadioListTile(
          title: Text("Тёмная"),
          value: HiveStrings.themeDark,
          groupValue: currentValue,
          onChanged: (value) => box.put(HiveStrings.themePath, HiveStrings.themeDark),
        ),
        RadioListTile(
          title: Text("Системная"),
          value: HiveStrings.themeSystem,
          groupValue: currentValue,
          onChanged: (value) => box.put(HiveStrings.themePath, HiveStrings.themeSystem),
        ),
      ],
    );
  }

  Widget _devGroup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0),
          child: Text("Для разработчиков"),
        ),
        ListTile(
          title: Text("Открыть логи"),
          onTap: () => AutoRouter.of(context).push(const LogsRoute()),
        ),
      ],
    );
  }
}
