import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_demo/core/widgets/app_loading_indicator.dart';
import 'package:messenger_demo/features/auth/auth_redirect/bloc/auth_redirect_bloc.dart';

@RoutePage()
class AuthRedirectScreen extends StatefulWidget {
  const AuthRedirectScreen({super.key});

  @override
  State<AuthRedirectScreen> createState() => _AuthRedirectScreenState();
}

class _AuthRedirectScreenState extends State<AuthRedirectScreen> {
  final _authRedirectBloc = AuthRedirectBloc();

  @override
  void initState() {
    _authRedirectBloc.add(AuthRedirectCheckEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthRedirectBloc, AuthRedirectState>(
      bloc: _authRedirectBloc,
      builder: (context, state) {
        return Scaffold(
          body: AppLoadingIndicator(),
        );
      },
    );
  }
}
