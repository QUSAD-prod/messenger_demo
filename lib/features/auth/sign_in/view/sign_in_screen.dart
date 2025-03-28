import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_demo/core/widgets/app_loading_indicator.dart';
import 'package:messenger_demo/core/widgets/app_text_form_field.dart';
import 'package:messenger_demo/core/widgets/app_dialogs.dart';
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

    _signInBloc.stream.listen(
      (state) {
        if (state is SignInFailureState && state.otherError != null && mounted) {
          final snackbar = SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              state.otherError!,
              style: TextStyle(color: Colors.white),
            ),
            showCloseIcon: true,
            closeIconColor: Colors.white,
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      bloc: _signInBloc,
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
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
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        focusNode: _emailFocus,
                        controller: _emailController,
                        onTapOutside: (p0) => _emailFocus.unfocus(),
                        forceErrorText: state is SignInFailureState ? state.emailError : null,
                      ),
                      SizedBox(height: 12.0),
                      AppTextFormField(
                        labelText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        focusNode: _passwordFocus,
                        controller: _passwordController,
                        onTapOutside: (p0) => _passwordFocus.unfocus(),
                        forceErrorText: state is SignInFailureState ? state.passwordError : null,
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () => _signInBloc.add(
                                SignInEmailPasswordEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Войти",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
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
                                  fontWeight: FontWeight.w500,
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
                        onPressed: () => _signInBloc.add(SignInGoogleEvent()),
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
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            state is SignInLoadingState ? AppLoadingIndicator() : Container(),
          ],
        );
      },
    );
  }
}
