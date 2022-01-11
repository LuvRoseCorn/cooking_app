import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/models.dart';

class MockService {
  Future<ExploreData> getExploreData() async {
    final recipePosters = await _getRecipePosters();
    final friendPosts = await _getFriendPosts();
    return ExploreData(recipePosters, friendPosts);
  }

  Future<List<ExploreRecipe>> _getRecipePosters() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final dataString = await _loadSampleData('assets/sample_data/sample_explore_recipes.json');
    final Map<String, dynamic> json = jsonDecode(dataString);
    if( json['recipes'] != null) {
      final recipes = <ExploreRecipe>[];
      json['recipes'].forEach((v){
        recipes.add(ExploreRecipe.fromJson(v));
      });
      return recipes;
    } else {
      return [];
    }
  }

  Future<List<Post>> _getFriendPosts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final dataString = await _loadSampleData('assets/sample_data/sample_friends_feed.json');
    final Map<String, dynamic> json = jsonDecode(dataString);
    if(json['feed'] != null) {
      final posts = <Post>[];
      json['feed'].forEach((v) {
        posts.add(Post.fromJson(v));
      });
      return posts;
    } else {
      return [];
    }
  }

  Future<String> _loadSampleData(String url) async {
    return rootBundle.loadString(url);
  }
}