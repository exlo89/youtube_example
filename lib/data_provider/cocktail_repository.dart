import 'dart:math';

import 'package:dio/dio.dart';
import 'package:youtube/data_provider/api_handler.dart';
import 'package:youtube/models/cocktail_model.dart';

class CocktailRepository {
  final ApiHandler _client = ApiHandler();

  static const _chars = 'abcdefghijklmnopqrstuvwxyz';
  final Random _rnd = Random();

  String _getRandomChar() => _chars[_rnd.nextInt(_chars.length)];

  Future<List<CocktailModel>> getRandomCocktails() async {
    String randomChar = _getRandomChar();
    Response<dynamic> response = await _client.get('/api/json/v1/1/search'
        '.php?f=$randomChar');
    if (response.data != null) {
      return List.generate(
        response.data['drinks'].length,
        (index) => CocktailModel.fromMap(response.data['drinks'][index]),
      ).toList();
    } else {
      return [];
    }
  }
}
