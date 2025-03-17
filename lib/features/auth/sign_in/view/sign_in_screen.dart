import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_demo/core/widgets/app_text_form_field.dart';
import 'package:messenger_demo/core/widgets/app_unable_dialogs.dart';
import 'package:messenger_demo/features/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:messenger_demo/features/auth/widgets/auth_social_login_buttons.dart';
import 'package:messenger_demo/router/router.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _signInBloc = SignInBloc();

  late FocusNode _emailFocus, _passwordFocus;
  late TextEditingController _emailController, _passwordController;

  @override
  void initState() {
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      bloc: _signInBloc,
      builder: (context, state) {
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
                  AppTextFormField(
                    labelText: "E-mail",
                    focusNode: _emailFocus,
                    controller: _emailController,
                    onTapOutside: (p0) => _emailFocus.unfocus(),
                  ),
                  SizedBox(height: 8.0),
                  AppTextFormField(
                    labelText: "Password",
                    obscureText: true,
                    focusNode: _passwordFocus,
                    controller: _passwordController,
                    onTapOutside: (p0) => _passwordFocus.unfocus(),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () => AppDialogs.showUnableDialog(context), //TODO add
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
                        onPressed: () => AppDialogs.showUnableDialog(context), //TODO add
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
                  AuthSocialLoginButtons.google(
                    style: Theme.of(context).brightness == Brightness.light ? SocialLoginButtonStyle.black : SocialLoginButtonStyle.white,
                    onPressed: () => AppDialogs.showUnableDialog(context), //TODO add
                  ),
                  SizedBox(height: 8.0),
                  AuthSocialLoginButtons.apple(
                    style: Theme.of(context).brightness == Brightness.light ? SocialLoginButtonStyle.black : SocialLoginButtonStyle.white,
                    onPressed: () => AppDialogs.showUnableDialog(context), //TODO add
                  ),
                  Spacer(flex: 2),
                  TextButton(
                    onPressed: () => context.replaceRoute(const SignUpRoute()),
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
      },
    );
  }
}
