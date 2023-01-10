// To parse this JSON data, do
//
//     final cocktailModel = cocktailModelFromMap(jsonString);

import 'dart:convert';

class CocktailModel {
  CocktailModel({
    this.strCategory,
    this.strDrink,
  });

  final String? strCategory;
  final String? strDrink;

  factory CocktailModel.fromJson(String str) => CocktailModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CocktailModel.fromMap(Map<String, dynamic> json) => CocktailModel(
    strCategory: json["strCategory"],
    strDrink: json["strDrink"],
  );

  Map<String, dynamic> toMap() => {
    "strCategory": strCategory,
    "strDrink": strDrink,
  };
}

List<CocktailModel> exampleCocktails = [
  CocktailModel(strDrink: 'Sex On The Beach',strCategory: 'Cocktail'),
  CocktailModel(strDrink: '501 Blue',strCategory: 'Gewöhnliches Getränk'),
  CocktailModel(strDrink: 'Dry Martini',strCategory: 'Cocktail'),
];