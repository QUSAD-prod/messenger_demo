import 'package:flutter/material.dart';

class SettingsTitleWidget extends StatelessWidget {
  const SettingsTitleWidget({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
      child: Text(title),
    );
  }
}
