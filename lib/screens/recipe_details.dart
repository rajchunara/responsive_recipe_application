import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:responsive_recipe_application/models/detailed_recipe.dart';

class RecipeDetails extends StatefulWidget {
  final String recipeId;

  const RecipeDetails({Key? key, required this.recipeId}) : super(key: key);

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState(recipeID: recipeId);
}

class _RecipeDetailsState extends State<RecipeDetails> {
  late DetailedRecipe _detailedRecipe = DetailedRecipe();
  final String recipeID;

  _RecipeDetailsState({required this.recipeID});

  late String detailedRecipeURL;

  @override
  void initState() {
    super.initState();
    detailedRecipeURL =
        "https://www.themealdb.com/api/json/v1/1/lookup.php?i=$recipeID";

    _fetchRecipe();
  }

  void _fetchRecipe() async {
    var url = Uri.parse(detailedRecipeURL);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable mealList = result["meals"];

      setState(() {
        _detailedRecipe = DetailedRecipe.fromJson(mealList.first);
      });
    } else {
      throw Exception('Failed to load recipe');
    }
  }

  Widget imageContainer() {
    return _detailedRecipe.strMealThumb.isNotEmpty
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          )
        : Image.network(
            _detailedRecipe.strMealThumb,
            fit: BoxFit.fill,
          );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double _getContainerWidth() {
      if (width >= 800) {
        return 800;
      } else {
        return double.infinity;
      }
    }

    double _getImageClippingRadius() {
      if (width >= 800) {
        return 0;
      } else {
        return 30;
      }
    }

    double _getImageHeight() {
      if (width < 700) {
        return width * 0.95;
      } else
        return 650;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _detailedRecipe.strMeal == ''
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : SafeArea(
              child: Center(
                child: Container(
                  width: _getContainerWidth(),
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(

                        backgroundColor: Colors.white,
                        expandedHeight: _getImageHeight(),
                        flexibleSpace: FlexibleSpaceBar(
                          background: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                    _getImageClippingRadius()),
                                bottomRight: Radius.circular(
                                    _getImageClippingRadius())),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Hero(
                                  tag: "recipe${_detailedRecipe.idMeal}",
                                  child: Image.network(
                                    _detailedRecipe.strMealThumb,
                                    fit: BoxFit.fill,
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
                              ],
                            ),
                          ),
                          title: Text(
                            _detailedRecipe.strMeal,
                            style: TextStyle(fontSize: 30.0),
                          ),
                          titlePadding: EdgeInsets.only(left: 20, bottom: 20),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              height: 30.0,
                              // color: Colors.red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _detailedRecipe.strArea,
                                    style: TextStyle(
                                        color: Colors.green[900],
                                        fontSize: 16),
                                  ),
                                  VerticalDivider(
                                    color: Colors.grey,
                                    width: 50.0,
                                  ),
                                  Text(
                                    _detailedRecipe.strCategory,
                                    style: TextStyle(
                                        color: Colors.green[900],
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            //Instructions UI
                            Container(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Instructions',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 3,
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 20),
                                    child: Text(
                                      _detailedRecipe.strInstructions,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 340,
                                  ),
                                ],
                              ),
                            )
                          ],
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
