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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 28.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Spacer(flex: 2),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 28.0),
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "Добро пожаловать в\nQUSAD Message!",
                    style: TextStyle(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 54.0),
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "Перед началом\nобщения нужно войти\nв аккаунт",
                    style: TextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Spacer(),
              IconButton.filled(
                onPressed: () => AutoRouter.of(context).push(const SignInRoute()),
                icon: Icon(Icons.navigate_next),
                iconSize: 42.0,
                tooltip: "Вход в аккаунт",
              ),
              Spacer(flex: 3),
              TextButton(
                // onPressed: () => AutoRouter.of(context).push(const SignUpRoute()),
                onPressed: () {},
                child: Text(
                  "Продолжить без аккаунта",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
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
