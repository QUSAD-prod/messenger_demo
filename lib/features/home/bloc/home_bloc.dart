import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeInitialEvent>((event, emit) {
      emit(state.copyWith(loading: true));
      User? user = GetIt.I<FirebaseAuth>().currentUser;
      emit(
        state.copyWith(
          user: user,
          loading: false,
        ),
      );
    });
  }
}
