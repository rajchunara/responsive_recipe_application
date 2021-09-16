import 'package:flutter/material.dart';
import 'package:responsive_recipe_application/models/brief_recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:responsive_recipe_application/widgets/recipe_card.dart';

class RecipeGrid extends StatelessWidget {
  final String category;
  final Future<List<BriefRecipe>> getAllRecipesByCategory;

  const RecipeGrid(
      {Key? key, required this.category, required this.getAllRecipesByCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    int crossAxisGridCount() {
      if (width <= 630) {
        return 2;
      } else if (width > 630 && width <= 900) {
        return 3;
      } else {
        return 4;
      }
    }

    double paddingOfGrid() {
      if (width <= 480) {
        return 10;
      } else if (width > 480 && width < 1000) {
        return 50;
      } else {
        return 100;
      }
    }

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
            padding: EdgeInsets.only(
                top: 80, left: paddingOfGrid(), right: paddingOfGrid()),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: crossAxisGridCount(),
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
