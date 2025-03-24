import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_demo/core/widgets/app_loading_indicator.dart';
import 'package:messenger_demo/core/widgets/app_text_form_field.dart';
import 'package:messenger_demo/core/widgets/app_unable_dialogs.dart';
import 'package:messenger_demo/features/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:messenger_demo/features/auth/widgets/auth_social_login_buttons.dart';
import 'package:messenger_demo/router/router.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpBloc = SignUpBloc();

  late FocusNode _emailFocus, _passwordFocus;
  late TextEditingController _emailController, _passwordController;

  @override
  void initState() {
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _signUpBloc.stream.listen(
      (state) {
        if (state is SignUpFailureState && state.otherError != null && mounted) {
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
    return BlocBuilder<SignUpBloc, SignUpState>(
      bloc: _signUpBloc,
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
                            "Создайте новый аккаунт",
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
                        forceErrorText: state is SignUpFailureState ? state.emailError : null,
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
                        forceErrorText: state is SignUpFailureState ? state.passwordError : null,
                      ),
                      SizedBox(height: 16.0),
                      FilledButton(
                        onPressed: () => _signUpBloc.add(
                          SignUpEmailPasswordEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        ),
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
                        onPressed: () => _signUpBloc.add(SignUpGoogleEvent()),
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
            ),
            state is SignUpLoadingState ? AppLoadingIndicator() : Container(),
          ],
        );
      },
    );
  }
}
