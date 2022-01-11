import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:fooderlich/api/recipe_model.dart';

class FavoriteManagement with ChangeNotifier {

  final List<APIRecipe> _currentRecipes = <APIRecipe>[];

  List<APIRecipe> findAllRecipes() {
    return _currentRecipes;
  }

  int insertRecipe(APIRecipe recipe) {
    _currentRecipes.add(recipe);
    notifyListeners();
    return 0;
  }

  void deleteRecipe(APIRecipe recipe) {
    _currentRecipes.remove(recipe);
    notifyListeners();
  }

  Future init() {
    return Future.value(null);
  }

  void close() {}
}