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
  @override
  String toString() {
    return strDrink ?? super.toString();
  }
}