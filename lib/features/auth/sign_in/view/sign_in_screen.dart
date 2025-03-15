import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text(
          "Войдите в свой аккаунт",
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
                style: Theme.of(context).brightness == Brightness.light ? SocialLoginButtonStyle.black : SocialLoginButtonStyle.white,
                onPressed: () {},
              ),
              SizedBox(
                height: 8.0,
              ),
              SocialLoginButtons.apple(
                style: Theme.of(context).brightness == Brightness.light ? SocialLoginButtonStyle.black : SocialLoginButtonStyle.white,
                onPressed: () {},
              ),
              Spacer(),
              TextButton(
                onPressed: () => AutoRouter.of(context).replace(const SignUpRoute()),
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
