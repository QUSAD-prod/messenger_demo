import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Создайте аккаунт",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      body: Center(
        child: Text(
          "Нет аккаунта?\nНу и пошёл ты нахуй!",
          style: TextTheme.of(context).headlineSmall?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
