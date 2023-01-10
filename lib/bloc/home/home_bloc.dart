import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube/models/cocktail_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeFetchedCocktails) {
        // Status auf 'loading' setzen
        emit(HomeInProgressState());
        try {

          await Future.delayed(const Duration(seconds: 3));
          List<CocktailModel> cocktails = exampleCocktails;

          // status auf 'success' setzen und Daten übergeben
          emit(HomeSuccessState(cocktails));
        } catch (error) {
          // status auf 'error' setzen
          emit(HomeFailureState());
        }
      }
    });
  }
}
