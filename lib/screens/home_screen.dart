import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_recipe_application/models/brief_recipe.dart';
import 'package:responsive_recipe_application/widgets/categories_list.dart';
import 'package:responsive_recipe_application/widgets/recipe_grid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String recipeCategory = 'Beef';
  List<String>? categoriesList;

  void changeRecipeCategory(String category) {
    setState(() {
      recipeCategory = category;
    });
  }

  Future<List<String>> _getAllCategories() async {
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

  Future<List<BriefRecipe>> _getAllRecipesByCategory(String category) async {
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: 600,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/home-page-image.jpg',
                    fit: BoxFit.cover,
                    color: const Color.fromRGBO(0, 0, 0, 0.35),
                    colorBlendMode: BlendMode.darken,
                  ),
                  const Center(
                    child: Text(
                      'Find Your Recipe',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            //Categories List view
            Container(
              height: 60,
              color: Colors.amber,
              child: CategoriesList(
                passRecipeCategory: changeRecipeCategory,
                activeCategory: recipeCategory,
                getAllCategories: _getAllCategories(),
              ),
            ),

            //Recipes grid view
            RecipeGrid(
              category: recipeCategory,
              getAllRecipesByCategory: _getAllRecipesByCategory(recipeCategory),
            ),
          ],
        ),
      ),
    );
  }
}
