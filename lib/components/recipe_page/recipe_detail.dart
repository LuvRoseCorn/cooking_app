import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fooderlich/api/recipe_model.dart';
import 'package:fooderlich/state_management/favorite_management.dart';
import 'package:provider/provider.dart';


class RecipeDetail extends StatelessWidget {
  final APIRecipe recipe;
  const RecipeDetail({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: CachedNetworkImage(
                      imageUrl: recipe.image,
                      alignment: Alignment.topLeft,
                      fit: BoxFit.fill,
                      width: size.width,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16),
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                          child: const BackButton(
                            color: Colors.white,
                          ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Món ăn :',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      recipe.label,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                      ),
                      onPressed: () {
                        if(Provider.of<FavoriteManagement>(context, listen: false).currentRecipes.contains(recipe)){
                          //print("da co");
                        }
                        else {
                          Provider.of<FavoriteManagement>(context, listen: false).insertRecipe(recipe);
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(Icons.favorite_border),
                      label: const Text(
                        'Yêu thích',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Chip(
                    label: Text('${recipe.calories.floor().toString()} KCAL'),
                  )),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Thành phần :',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 400,
                  width: size.width,
                  child: ListView.builder(
                    itemCount: recipe.ingredients.length,
                    itemBuilder: (context, index){
                      APIIngredients ingredient  = recipe.ingredients[index];
                      return Text(
                        '- ${ingredient.name}',
                        style: Theme.of(context).textTheme.bodyText1,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}