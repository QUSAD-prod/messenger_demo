import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:messenger_demo/core/widgets/unable_dialogs.dart';
import 'package:messenger_demo/features/auth/widgets/social_login_buttons.dart';
import 'package:messenger_demo/router/router.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0),
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "Войдите в свой аккаунт",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Spacer(),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "E-mail",
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Пароль",
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          "Войти",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  TextButton(
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        "Забыли Пароль?",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Divider(
                  height: 0.5,
                  color: Theme.of(context).brightness == Brightness.light ? Colors.black.withAlpha(75) : Colors.white.withAlpha(75),
                ),
              ),
              SocialLoginButtons.google(
                style: Theme.of(context).brightness == Brightness.light ? SocialLoginButtonStyle.black : SocialLoginButtonStyle.white,
                onPressed: () {},
              ),
              SizedBox(height: 8.0),
              SocialLoginButtons.apple(
                style: Theme.of(context).brightness == Brightness.light ? SocialLoginButtonStyle.black : SocialLoginButtonStyle.white,
                onPressed: () => UnableDialogs.show(context), //TODO add
              ),
              Spacer(flex: 2),
              TextButton(
                onPressed: () => AutoRouter.of(context).replace(const SignUpRoute()),
                child: Text(
                  "Нет аккаунта? Зарегистрироваться",
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
