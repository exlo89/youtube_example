part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeInProgressState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<CocktailModel> cocktails;

  HomeSuccessState(this.cocktails);
}

class HomeFailureState extends HomeState {}
