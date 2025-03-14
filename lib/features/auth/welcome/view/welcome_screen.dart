import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Spacer(flex: 15),
            Text(
              "Добро пожаловать!",
              style: TextTheme.of(context).headlineLarge?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            Spacer(flex: 1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "Перед началом общения нужно войти в аккаунт",
                style: TextTheme.of(context).headlineSmall?.copyWith(fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(flex: 1),
            IconButton.filled(
              onPressed: () => {},
              icon: Icon(Icons.navigate_next),
              iconSize: 36.0,
            ),
            Spacer(flex: 13),
            TextButton(
              onPressed: () {},
              child: Text(
                "Нет аккаунта? Зарегистрироваться",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
