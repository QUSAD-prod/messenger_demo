import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitialState()) {
    on<WelcomeAnonymusAuthEvent>(
      (event, emit) async {
        try {
          emit(WelcomeLoadingState());
          GetIt.I<Talker>().info('Firebase: try signIn with temporary account."');
          GetIt.I<FirebaseAuth>().signInAnonymously();
          GetIt.I<Talker>().info("Firebase: signed in with temporary account.");
        } on FirebaseAuthException catch (e) {
          switch (e.code) {
            case "operation-not-allowed":
              emit(WelcomeFailureState());
              GetIt.I<Talker>().error("Firebase: anonymous auth hasn't been enabled for this project.");
              break;
            default:
              emit(WelcomeFailureState());
              GetIt.I<Talker>().error("Firebase: Unknown error.\n${e.code}");
          }
        }
      },
    );
  }
}
