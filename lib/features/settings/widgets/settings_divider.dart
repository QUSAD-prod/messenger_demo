import 'package:flutter/material.dart';

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 16.0,
      thickness: 1.0,
      indent: 8.0,
      endIndent: 8.0,
      color: Theme.of(context).brightness == Brightness.light ? Colors.black.withAlpha(128) : Colors.white.withAlpha(128),
    );
  }
}
