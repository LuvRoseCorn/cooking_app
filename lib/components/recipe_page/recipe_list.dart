import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../api/recipe_model.dart';
import '../../api/recipe_service.dart';
import 'recipe_card.dart';
import 'recipe_detail.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {

  late TextEditingController searchTextController;
  final ScrollController _scrollController = ScrollController();
  List<APIHits> currentSearchList = [];
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 20;
  int pageCount = 20;
  bool hasMore = false;
  bool loading = false;
  bool inErrorState = false;
  List<String> previousSearches = <String>[];

  @override
  void initState() {
    super.initState();

    searchTextController = TextEditingController(text: '');
    _scrollController
      .addListener(() {
        final triggerFetchMoreSize =
            0.7 * _scrollController.position.maxScrollExtent;

        if (_scrollController.position.pixels > triggerFetchMoreSize) {
          if (hasMore &&
              currentEndPosition < currentCount &&
              !loading &&
              !inErrorState) {
            setState(() {
              loading = true;
              currentStartPosition = currentEndPosition;
              currentEndPosition =
                  min(currentStartPosition + pageCount, currentCount);
            });
          }
        }
      });
  }

  Future<APIRecipeQuery> getRecipeData(String query, int from, int to) async {
    final recipeJson = await RecipeService().getRecipes(query, from, to);
    final recipeMap = json.decode(recipeJson);
    return APIRecipeQuery.fromJson(recipeMap);
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16,),
          Text(
            "Tìm món ăn 🍳",
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 16,),
          _buildSearchCard(),
          const SizedBox(height: 8),
          searchTextController.text == '' ? Expanded(child: Center(child: Image.asset('assets/illus_pics/search_recipe.png'))): _buildRecipeLoader(context),
        ],
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                startSearch(searchTextController.text);
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            ),
            const SizedBox(
              width: 6.0,
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Tìm kiếm'),
                        autofocus: false,
                        textInputAction: TextInputAction.done,
                        controller: searchTextController,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startSearch(String value) {
    setState(() {
      currentSearchList.clear();
      currentCount = 0;
      currentEndPosition = pageCount;
      currentStartPosition = 0;
      hasMore = true;
      value = value.trim();
    });
  }

  Widget _buildRecipeLoader(BuildContext context) {
    if (searchTextController.text.length < 3) {
      return Container();
    }
    return FutureBuilder<APIRecipeQuery>(
      future: getRecipeData(searchTextController.text.trim(),
          currentStartPosition, currentEndPosition),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }

          loading = false;
          final query = snapshot.data;
          inErrorState = false;
          if (query != null) {
            currentCount = query.count;
            hasMore = query.more;
            currentSearchList.addAll(query.hits);
            if (query.to < currentEndPosition) {
              currentEndPosition = query.to;
            }
          }
          return _buildRecipeList(context, currentSearchList);
        } else {
          if (currentCount == 0) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _buildRecipeList(context, currentSearchList);
          }
        }
      },
    );
  }

  Widget _buildRecipeList(BuildContext recipeListContext, List<APIHits> hits) {
    final size = MediaQuery.of(context).size;
    const itemHeight = 310;
    final itemWidth = size.width / 2;
    return Flexible(
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemCount: hits.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildRecipeCard(recipeListContext, hits, index);
        },
      ),
    );
  }

  Widget _buildRecipeCard(
      BuildContext topLevelContext, List<APIHits> hits, int index) {
    final recipe = hits[index].recipe;
    return GestureDetector(
      onTap: () {
        Navigator.push(topLevelContext, MaterialPageRoute(
          builder: (context) {
            return RecipeDetail(recipe: recipe);
          },
        ));
      },
      child: recipeCard(recipe),
    );
  }
}