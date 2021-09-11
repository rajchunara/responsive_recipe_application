import 'package:flutter/material.dart';
import 'package:responsive_recipe_application/models/brief_recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:responsive_recipe_application/widgets/recipe_card.dart';

class RecipeGrid extends StatefulWidget {
  const RecipeGrid({Key? key}) : super(key: key);

  @override
  _RecipeGridState createState() => _RecipeGridState();
}

class _RecipeGridState extends State<RecipeGrid> {
  Future<List<BriefRecipe>> _getAllRecipesByCategory() async {
    const String _categoryApiUrl =
        "https://www.themealdb.com/api/json/v1/1/filter.php?c=Beef";
    var url = Uri.parse(_categoryApiUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable recipeList = result["meals"];

      return recipeList.map((recipe) {
        return BriefRecipe.fromJson(recipe);
      }).toList();
    } else {
      throw Exception('Failed to load Recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getAllRecipesByCategory(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 80, left: 200, right: 200),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              children: [
                ...snapshot.data.map((item) {
                  return RecipeCard(recipe: item);
                }).toList()
              ],
            ),
          );
        }
      },
    );
  }
}
