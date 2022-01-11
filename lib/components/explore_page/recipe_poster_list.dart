import 'package:flutter/material.dart';
import 'package:fooderlich/components/explore_page/widgets/poster.dart';
import 'package:fooderlich/models/explore_recipe.dart';


class RecipePosterList extends StatelessWidget {
  final List<ExploreRecipe> exploreRecipeList;
  const RecipePosterList({Key? key, required this.exploreRecipeList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Món ăn mỗi ngày 🍳',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 16),
          Container(
            height: 400,
            color: Colors.transparent,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: exploreRecipeList.length,
              itemBuilder: (context, index) {
                final recipe = exploreRecipeList[index];
                return Poster(exploreRecipe: recipe);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 16);
              },
            ),
          ),
        ],
      ),
    );
  }
}

