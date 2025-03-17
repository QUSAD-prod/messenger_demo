import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:messenger_demo/core/widgets/app_unable_dialogs.dart';
import 'package:messenger_demo/features/auth/widgets/auth_social_login_buttons.dart';
import 'package:messenger_demo/router/router.dart';

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
                    "Создайте новый аккаунт",
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
              SizedBox(height: 12.0),
              FilledButton(
                onPressed: () {},
                child: Center(
                  child: Text(
                    "Зарегистрироваться",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Divider(
                  height: 0.5,
                  color: Theme.of(context).brightness == Brightness.light ? Colors.black.withAlpha(75) : Colors.white.withAlpha(75),
                ),
              ),
              AuthSocialLoginButtons.google(
                style: Theme.of(context).brightness == Brightness.light ? SocialLoginButtonStyle.black : SocialLoginButtonStyle.white,
                onPressed: () => AppDialogs.showUnableDialog(context), //TODO add
              ),
              SizedBox(
                height: 8.0,
              ),
              AuthSocialLoginButtons.apple(
                style: Theme.of(context).brightness == Brightness.light ? SocialLoginButtonStyle.black : SocialLoginButtonStyle.white,
                onPressed: () => AppDialogs.showUnableDialog(context), //TODO add
              ),
              Spacer(flex: 2),
              TextButton(
                onPressed: () => context.replaceRoute(const SignInRoute()),
                child: Text(
                  "Уже есть аккаунт? Войти",
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
