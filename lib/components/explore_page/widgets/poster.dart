import 'package:flutter/material.dart';
import 'package:fooderlich/app_theme.dart';
import 'package:fooderlich/models/explore_recipe.dart';

class Poster extends StatelessWidget {
  final ExploreRecipe exploreRecipe;
  const Poster({Key? key, required this.exploreRecipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints.expand(
        width: 350,
        height: 450,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(exploreRecipe.backgroundImage),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Text(
            exploreRecipe.subtitle,
            style: CookingAppTheme.darkTextTheme.bodyText1,
          ),
          Positioned(
            child: Text(
              exploreRecipe.title,
              style: CookingAppTheme.darkTextTheme.headline2,
            ),
            top: 20,
          ),
          Positioned(
            child: Text(
              exploreRecipe.message,
              style: CookingAppTheme.darkTextTheme.bodyText1,
            ),
            bottom: 30,
            right: 0,
          ),
          Positioned(
            child: Text(
              exploreRecipe.authorName,
              style: CookingAppTheme.darkTextTheme.bodyText1,
            ),
            bottom: 10,
            right: 0,
          )
        ],
      ),
    );
  }
}
