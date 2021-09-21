import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_recipe_application/models/brief_recipe.dart';
import 'package:responsive_recipe_application/provider/recipe_provider.dart';
import 'package:responsive_recipe_application/widgets/categories_list.dart';
import 'package:responsive_recipe_application/widgets/recipe_grid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Consumer<RecipeProvider>(
      builder: (context, recipeProvider, child) {
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
                      Center(
                        child: Text(
                          'Delicious Recipes',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: (width > 500.0) ? 50.0 : 40.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                //Categories List view
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  color: Colors.amber,
                  child: Center(
                    child: CategoriesList(
                      passRecipeCategory: recipeProvider.changeRecipeCategory,
                      activeCategory: recipeProvider.activeCategory,
                      getAllCategories: recipeProvider.getAllCategories(),
                    ),
                  ),
                ),

                //Recipes grid view
                RecipeGrid(
                  category: recipeProvider.activeCategory,
                  getAllRecipesByCategory: recipeProvider
                      .getAllRecipesByCategory(recipeProvider.activeCategory),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
