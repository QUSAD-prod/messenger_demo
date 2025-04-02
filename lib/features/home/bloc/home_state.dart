// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.user,
    this.loading = false,
  });

  final User? user;
  final bool loading;

  @override
  List<Object?> get props => [user, loading];

  HomeState copyWith({
    User? user,
    bool? loading,
  }) {
    return HomeState(
      user: user ?? this.user,
      loading: loading ?? this.loading,
    );
  }
}
