import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_demo/core/widgets/app_loading_indicator.dart';
import 'package:messenger_demo/core/widgets/app_text_form_field.dart';
import 'package:messenger_demo/features/auth/reset_password/bloc/reset_password_bloc.dart';

@RoutePage()
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _resetPasswordBloc = ResetPasswordBloc();

  late FocusNode _emailFocus;
  late TextEditingController _emailController;

  late StreamSubscription<ResetPasswordState> _streamSubscription;

  @override
  void initState() {
    _emailFocus = FocusNode();
    _emailController = TextEditingController();

    _streamSubscription = _resetPasswordBloc.stream.listen(
      (state) {
        if (state is ResetPasswordFailureState && state.otherError != null && mounted) {
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
        } else if (state is ResetPasswordLoadedState && mounted) {
          final snackbar = SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Письмо со ссылкой для сброса пароля успешно отправлено",
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
  void dispose() {
    _emailFocus.dispose();
    _emailController.dispose();
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      bloc: _resetPasswordBloc,
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 28.0),
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
                          "Восстановите пароль",
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
                      forceErrorText: state is ResetPasswordFailureState ? state.emailError : null,
                    ),
                    Spacer(),
                    Text(
                      "Отправить письмо со ссылкой\nдля сброса пароля",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.0),
                    FilledButton(
                      onPressed: () => _resetPasswordBloc.add(
                        ResetPasswordSendEvent(email: _emailController.text),
                      ),
                      child: Text(
                        "Отправить",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Spacer(flex: 2),
                  ],
                ),
              ),
            ),
            state is ResetPasswordLoadingState ? AppLoadingIndicator() : Container(),
          ],
        );
      },
    );
  }
}
