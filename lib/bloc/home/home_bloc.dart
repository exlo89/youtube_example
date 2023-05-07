import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube/data_provider/cocktail_repository.dart';
import 'package:youtube/models/cocktail_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  CocktailRepository repository = CocktailRepository();

  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeFetchedCocktails) {
        // Status auf 'loading' setzen
        emit(HomeInProgressState());
        try {
          List<CocktailModel> cocktails = await repository.getRandomCocktails();

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
