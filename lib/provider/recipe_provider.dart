import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:core';

import 'package:responsive_recipe_application/models/brief_recipe.dart';

class RecipeProvider extends ChangeNotifier {
  String activeCategory = 'Beef';
  List<String>? categoriesList;

  void changeRecipeCategory(String category) {
    activeCategory = category;
    notifyListeners();
  }

  Future<List<String>> getAllCategories() async {
    const String _categoriesListURL =
        "https://www.themealdb.com/api/json/v1/1/list.php?c=list";
    var url = Uri.parse(_categoriesListURL);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable catgList = result["meals"];

      categoriesList = [
        ...catgList.map((categoryJson) {
          return categoryJson["strCategory"];
        }).toList()
      ];
      return [
        'All',
        ...catgList.map((categoryJson) {
          return categoryJson["strCategory"];
        }).toList()
      ];
    } else {
      throw Exception('Failed to load categories list');
    }
  }

  Future<List<BriefRecipe>> getAllRecipesByCategory(String category) async {
    if (category == 'All') {
      List<BriefRecipe> recipeList = [];

      for (String categ in categoriesList!) {
        recipeList = [...recipeList, ...await getRecipesForOneCategory(categ)];
      }
      return Future.value(recipeList);
    } else {
      return getRecipesForOneCategory(category);
    }
  }

  Future<List<BriefRecipe>> getRecipesForOneCategory(String category) async {
    String _categoryApiUrl =
        "https://www.themealdb.com/api/json/v1/1/filter.php?c=$category";
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
}
