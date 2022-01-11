import 'package:flutter/material.dart';
import 'package:fooderlich/api/mock_service.dart';
import 'package:fooderlich/components/explore_page/friend_post_list.dart';
import 'package:fooderlich/components/explore_page/recipe_poster_list.dart';
import 'package:fooderlich/models/explore_data.dart';

class ExploreScreen extends StatelessWidget {
  final mockService = MockService();
  ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          return ListView(
            children: [
              RecipePosterList(exploreRecipeList: snapshot.data?.recipePosters ?? []),
              const SizedBox(height: 16),
              FriendPostList(friendPostList: snapshot.data?.friendPosts ?? []),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
