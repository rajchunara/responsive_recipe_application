import 'package:flutter/material.dart';
import 'package:responsive_recipe_application/models/brief_recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:responsive_recipe_application/widgets/recipe_card.dart';

class RecipeGrid extends StatelessWidget {
  final String category;
  final Future<List<BriefRecipe>>  getAllRecipesByCategory;

  const RecipeGrid(
      {Key? key, required this.category, required this.getAllRecipesByCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllRecipesByCategory,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const Center(
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
