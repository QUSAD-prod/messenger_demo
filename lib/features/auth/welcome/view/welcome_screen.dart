import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:messenger_demo/router/router.dart';

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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Spacer(flex: 15),
              Text(
                "Добро пожаловать в\nQUSAD Message!",
                style: TextTheme.of(context).headlineMedium?.copyWith(fontWeight: FontWeight.w600),
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
                onPressed: () => AutoRouter.of(context).push(const SignInRoute()),
                icon: Icon(Icons.navigate_next),
                iconSize: 36.0,
                tooltip: "Вход в аккаунт",
              ),
              Spacer(flex: 13),
              TextButton(
                onPressed: () => AutoRouter.of(context).push(const SignUpRoute()),
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
      ),
    );
  }
}
