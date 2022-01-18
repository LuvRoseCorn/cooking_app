import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fooderlich/api/recipe_model.dart';
import 'package:fooderlich/components/recipe_page/recipe_detail.dart';
import 'package:fooderlich/state_management/favorite_management.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<APIRecipe> recipes = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _buildRecipeList(context),
    );
  }

  Widget _buildRecipeList(BuildContext context) {
    return Consumer<FavoriteManagement>(builder: (context, favoriteManagement, child) {
      favoriteManagement.getAllRecipes();
      recipes = favoriteManagement.currentRecipes;
      if(recipes.isEmpty) {
        return Center(child: Image.asset('assets/illus_pics/no_recipe.png'));
      } else {
        return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (BuildContext context, int index) {
              final recipe = recipes[index];
              return SizedBox(
                height: 100,
                child: Slidable(
                  actionPane: const SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Card(
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    //color: Colors.white,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CachedNetworkImage(
                              imageUrl: recipe.image,
                              height: 120,
                              width: 60,
                              fit: BoxFit.cover),
                          title: Text(
                            recipe.label,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline3,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  RecipeDetail(recipe: recipe)),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    IconSlideAction(
                        caption: 'Xóa',
                        color: Colors.transparent,
                        foregroundColor: Colors.black,
                        iconWidget: const Icon(Icons.delete, color: Colors.red),
                        onTap: () => deleteRecipe(favoriteManagement, recipe)),
                  ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                        caption: 'Xóa',
                        color: Colors.transparent,
                        foregroundColor: Colors.black,
                        iconWidget: const Icon(Icons.delete, color: Colors.red),
                        onTap: () => deleteRecipe(favoriteManagement, recipe)),
                  ],
                ),
              );
            });
      }
    });
  }

  void deleteRecipe(FavoriteManagement favoriteManagement, APIRecipe recipe) async {
    favoriteManagement.deleteRecipe(recipe);
    setState(() {});
  }
}