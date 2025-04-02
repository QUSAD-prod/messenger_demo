import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final typeId = 0; // Put an ID you didn't use yet.

  @override
  ThemeMode read(BinaryReader reader) {
    switch (reader.readString()) {
      case "ThemeMode.light":
        break;
      case "ThemeMode.dark":
        break;
    }
    return ThemeMode.system;
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    writer.writeString(obj.toString());
  }
}
