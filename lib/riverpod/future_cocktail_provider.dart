import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube/data_provider/cocktail_repository.dart';
import 'package:youtube/models/cocktail_model.dart';

final cocktailFutureProvider = FutureProvider.autoDispose<List<CocktailModel>>(
        (ref) {
  final cocktailRepository = ref.watch(cocktailRepositoryProvider);
  return cocktailRepository.getRandomCocktails();
});

final cocktailRepositoryProvider = Provider<CocktailRepository>((ref) {
  return CocktailRepository(); // declared elsewhere
});
