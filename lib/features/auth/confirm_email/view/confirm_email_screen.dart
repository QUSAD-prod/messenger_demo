import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger_demo/core/widgets/app_loading_indicator.dart';
import 'package:messenger_demo/features/auth/confirm_email/bloc/confirm_email_bloc.dart';

@RoutePage()
class ConfirmEmailScreen extends StatefulWidget {
  const ConfirmEmailScreen({super.key});

  @override
  State<ConfirmEmailScreen> createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {
  final _confirmEmailBloc = ConfirmEmailBloc();
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {});
        if (timer.tick % 5 == 0) {
          _confirmEmailBloc.add(CheckConfirmEmailEvent());
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmEmailBloc, ConfirmEmailState>(
      bloc: _confirmEmailBloc,
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
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
                          "Подтвердите свой e-mail",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      GetIt.I<FirebaseAuth>().currentUser!.email ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Text(
                      "Отправить письмо со ссылкой для подтверждения e-mail",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    FilledButton(
                      onPressed: state is ConfirmEmailLoadedState && state.timestamp.difference(DateTime.now()).inSeconds > 0
                          ? null
                          : () => _confirmEmailBloc.add(SendConfirmEmailEvent()),
                      child: Text(
                        "Отправить",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      state is ConfirmEmailLoadedState && state.timestamp.difference(DateTime.now()).inSeconds > 0
                          ? "Повторить отправку через ${state.timestamp.difference(DateTime.now()).inSeconds}"
                          : state is ConfirmEmailFailureState
                              ? "Ошибка отправки"
                              : "",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: state is ConfirmEmailFailureState
                            ? Colors.red
                            : Theme.of(context).brightness == Brightness.light
                                ? Colors.black.withAlpha(100)
                                : Colors.white.withAlpha(100),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(flex: 2),
                  ],
                ),
              ),
            ),
            state is ConfirmEmailLoadingState ? AppLoadingIndicator() : Container(),
          ],
        );
      },
    );
  }
}
