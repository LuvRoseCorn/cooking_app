import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fooderlich/api/recipe_model.dart';

class FavoriteManagement with ChangeNotifier {

  final List<APIRecipe> _currentRecipes = <APIRecipe>[];
  List<APIRecipe> get currentRecipes {
    return [..._currentRecipes];
  }
  final _collectionName = 'favorite_recipes';

  Future<void> getAllRecipes() async {
    final email = FirebaseAuth.instance.currentUser!.email.toString();
    DocumentSnapshot<Map<String, dynamic>> results =
    await FirebaseFirestore.instance.doc('$_collectionName/${email}').get();
    if (!results.exists) {
      return;
    } else {
      results.data()!.forEach((key, value) {
        _currentRecipes.add(APIRecipe.fromJson(value));
      });
    }
    notifyListeners();
  }

  Future<void> insertRecipe(APIRecipe recipe) async {
    final email = FirebaseAuth.instance.currentUser!.email.toString();
    DocumentSnapshot<Map<String, dynamic>> results =
    await FirebaseFirestore.instance.doc('$_collectionName/${email}').get();

    if (!results.exists) {
      _currentRecipes.add(recipe);
      await FirebaseFirestore.instance
          .doc('$_collectionName/${email}')
          .set({"0": recipe.toJson()});
    } else if (results
        .data()!
        .values
        .any((element) => element['label'] == recipe.label)) {
      return;
    } else {
      _currentRecipes.add(recipe);
      await FirebaseFirestore.instance.doc('$_collectionName/${email}').update(
          _currentRecipes
              .asMap()
              .map((key, value) => MapEntry(key.toString(), value.toJson())));
    }
    notifyListeners();
  }

  Future<void> deleteRecipe(APIRecipe recipe) async {
    final email = FirebaseAuth.instance.currentUser!.email.toString();
    DocumentSnapshot<Map<String, dynamic>> results =
    await FirebaseFirestore.instance.doc('$_collectionName/${email}').get();

    if (!results.exists) {
      return;
    } else if (!results
        .data()!
        .values
        .any((element) => element['label'] == recipe.label)) {
      return;
    } else {
      _currentRecipes.removeWhere((element) => element.label == recipe.label);
      await FirebaseFirestore.instance.doc('$_collectionName/${email}').update(
          _currentRecipes
              .asMap()
              .map((key, value) => MapEntry(key.toString(), value.toJson())));
    }
    notifyListeners();
  }
  void close() {}
}