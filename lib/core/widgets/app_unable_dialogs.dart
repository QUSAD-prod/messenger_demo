import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  static void showUnableDialog(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) => AlertDialog(
          title: Text("Пока недоступно"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Text("Сейчас эта функция находится в разработке."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Center(child: Text("ОК")),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) => CupertinoAlertDialog(
          title: Text("Пока недоступно"),
          content: Text("Сейчас эта функция находится в разработке."),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text("ОК"),
            ),
          ],
        ),
      );
    }
  }
}
