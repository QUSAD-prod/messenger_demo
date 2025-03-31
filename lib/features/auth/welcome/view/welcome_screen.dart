import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger_demo/core/widgets/app_loading_indicator.dart';
import 'package:messenger_demo/features/auth/welcome/bloc/welcome_bloc.dart';
import 'package:messenger_demo/router/app_router.dart';

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _welcomeBloc = WelcomeBloc();

  @override
  void initState() {
    super.initState();
    GetIt.I<FirebaseAuth>().userChanges().listen(
      (user) {
        if (mounted && user != null) {
          AutoRouter.of(context).reevaluateGuards();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<WelcomeBloc, WelcomeState>(
        bloc: _welcomeBloc,
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 28.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Spacer(flex: 3),
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
                        onPressed: () => GetIt.I<AppRouter>().push(const SignInRoute()),
                        icon: Icon(Icons.navigate_next),
                        iconSize: 42.0,
                        tooltip: "Вход в аккаунт",
                      ),
                      Spacer(flex: 4),
                      // TextButton(
                      //   onPressed: () => _welcomeBloc.add(
                      //     WelcomeAnonymusAuthEvent(),
                      //   ),
                      //   child: Text(
                      //     "Продолжить без аккаунта",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w600,
                      //       fontSize: 16,
                      //     ),
                      //   ),
                      // ),
                      TextButton(
                        onPressed: () => GetIt.I<AppRouter>().replace(const SignUpRoute()),
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
              state is WelcomeLoadingState ? AppLoadingIndicator() : Container(),
            ],
          );
        },
      ),
    );
  }
}
