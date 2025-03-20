import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:messenger_demo/core/strings/hive_strings.dart';
import 'package:messenger_demo/core/widgets/app_unable_dialogs.dart';
import 'package:messenger_demo/features/settings/bloc/settings_bloc.dart';
import 'package:messenger_demo/features/settings/widgets/settings_divider.dart';
import 'package:messenger_demo/features/settings/widgets/settings_title_widget.dart';
import 'package:messenger_demo/router/router.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _settingsBloc = SettingsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: _settingsBloc,
      builder: (context, state) {
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
                      _themeGroup(context: context, box: box),
                      SettingsDivider(),
                      _accountGroup(),
                      SettingsDivider(),
                      _devGroup(),
                      SettingsDivider(),
                      _aboutGroup(box: box),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Column _aboutGroup({required Box<dynamic> box}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8.0),
        Text("Версия приложения: ${box.get(HiveStrings.versionPath)}"),
        Text("Номер сборки: ${(box.get(HiveStrings.buildNumberPath) == "" ? "-" : box.get(HiveStrings.buildNumberPath))}"),
        Text("by QUSAD.prod"),
      ],
    );
  }

  Widget _accountGroup() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsTitleWidget(title: "Настройки аккаунта"),
        ListTile(
          trailing: Icon(Icons.logout_outlined),
          title: Text("Выйти из аккаунта"),
          onTap: () => _settingsBloc.add(SettingsSignOutEvent()),
        ),
        ListTile(
          trailing: Icon(Icons.delete_outlined),
          title: Text("Удалить аккаунт"),
          onTap: () => AppDialogs.showUnableDialog(context),
        ),
      ],
    );
  }

  Widget _themeGroup({required BuildContext context, required Box box}) {
    String currentValue = box.get(HiveStrings.themePath, defaultValue: HiveStrings.themeSystem);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsTitleWidget(title: "Тема"),
        RadioListTile(
          title: Text("Светлая"),
          secondary: Icon(Icons.light_mode_outlined),
          value: HiveStrings.themeLight,
          groupValue: currentValue,
          onChanged: (value) => box.put(HiveStrings.themePath, HiveStrings.themeLight),
        ),
        RadioListTile(
          title: Text("Тёмная"),
          secondary: Icon(Icons.mode_night_outlined),
          value: HiveStrings.themeDark,
          groupValue: currentValue,
          onChanged: (value) => box.put(HiveStrings.themePath, HiveStrings.themeDark),
        ),
        RadioListTile(
          title: Text("Системная"),
          secondary: Icon(Icons.sync_outlined),
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
        SettingsTitleWidget(title: "Для разработчиков"),
        ListTile(
          trailing: Icon(Icons.terminal_outlined),
          title: Text("Открыть логи"),
          onTap: () => context.pushRoute(const LogsRoute()),
        ),
      ],
    );
  }
}
