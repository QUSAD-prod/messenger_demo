import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:messenger_demo/features/auth/widgets/social_login_buttons.dart';
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
      appBar: AppBar(
        title: Text(
          "Создайте аккаунт",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Spacer(),
              SocialLoginButtons.google(
                style: Theme.of(context).brightness == Brightness.light ? SocialLoginButtonStyle.black : SocialLoginButtonStyle.black,
                onPressed: () {},
              ),
              SizedBox(
                height: 8.0,
              ),
              SocialLoginButtons.apple(
                style: Theme.of(context).brightness == Brightness.light ? SocialLoginButtonStyle.black : SocialLoginButtonStyle.black,
                onPressed: () {},
              ),
              Spacer(),
              TextButton(
                onPressed: () => AutoRouter.of(context).replace(const SignInRoute()),
                child: Text(
                  "Уже есть аккаунт? Войти",
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
