import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger_demo/core/widgets/app_dialogs.dart';
import 'package:messenger_demo/core/widgets/app_loading_indicator.dart';
import 'package:messenger_demo/features/home/bloc/home_bloc.dart';
import 'package:messenger_demo/router/app_router.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeBloc = HomeBloc();

  @override
  void initState() {
    _homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: _homeBloc,
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text("Чаты"),
              ),
              drawer: Drawer(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: Svg(
                            'assets/svg/profile_background.svg',
                          ),
                          colorFilter: ColorFilter.mode(
                            Colors.white.withAlpha(200),
                            BlendMode.darken,
                          ),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              margin: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(220),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.account_circle_outlined,
                                  size: 38,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white.withAlpha(220),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(right: 32),
                                    child: Text(
                                      state.user != null && state.user!.email != null ? state.user!.email! : '',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(right: 12),
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        state.user != null ? "ID: ${state.user!.uid}" : 'ID: -',
                                        style: TextStyle(
                                          color: Colors.black.withAlpha(200),
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.account_circle,
                        size: 28,
                      ),
                      title: const Text('Аккаунт'),
                      onTap: () => AppDialogs.showUnableDialog(context), //TODO add
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.settings,
                        size: 28,
                      ),
                      title: const Text('Настройки'),
                      onTap: () => GetIt.I<AppRouter>().push(const SettingsRoute()),
                    ),
                  ],
                ),
              ),
              body: Container(),
            ),
            state.loading ? AppLoadingIndicator() : Container(),
          ],
        );
      },
    );
  }
}
