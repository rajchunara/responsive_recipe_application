import 'package:flutter/material.dart';

import 'package:responsive_recipe_application/models/brief_recipe.dart';
import 'package:responsive_recipe_application/screens/recipe_details.dart';

class RecipeCard extends StatelessWidget {
  final BriefRecipe recipe;

  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Hero(
        tag: "recipe${recipe.idMeal}",
        child: Container(
          // color: Colors.red,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 17.0, vertical: 17.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      recipe.strMealThumb,
                    ),
                  ),
                  Positioned(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.black.withAlpha(0),
                          Colors.black.withAlpha(0),
                          Colors.black38,
                          Colors.black54
                        ],
                      )),
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150.0,
                          child: Text(
                            recipe.strMeal,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetails(
              recipeId: recipe.idMeal,
            ),
          ),
        );
      },
    );
  }

  Padding recipeCard() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  spreadRadius: -1.0,
                  offset: Offset(10.0, 10.0))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: Container(
            child: Stack(
              children: [
                Image.network(
                  recipe.strMealThumb,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(recipe.strMeal),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
