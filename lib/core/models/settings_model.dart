import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 1)
class SettingsModel {
  SettingsModel({
    this.appName = '',
    this.packageName = '',
    this.version = '',
    this.buildNumber = '',
    this.themeMode = ThemeMode.system,
  });

  @HiveField(0)
  final String appName;
  @HiveField(1)
  final String packageName;
  @HiveField(2)
  final String version;
  @HiveField(3)
  final String buildNumber;

  @HiveField(4)
  final ThemeMode themeMode;

  SettingsModel copyWith({
    String? appName,
    String? packageName,
    String? version,
    String? buildNumber,
    ThemeMode? themeMode,
  }) {
    return SettingsModel(
      appName: appName ?? this.appName,
      packageName: packageName ?? this.packageName,
      version: version ?? this.version,
      buildNumber: buildNumber ?? this.buildNumber,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
