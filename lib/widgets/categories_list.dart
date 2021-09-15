import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:core';

class CategoriesList extends StatelessWidget {
  final Function passRecipeCategory;
  final String activeCategory;
  final Future<List<String>> getAllCategories;

  const CategoriesList({
    Key? key,
    required this.passRecipeCategory,
    required this.activeCategory,
    required this.getAllCategories,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllCategories,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...snapshot.data.map((item) {
                bool isActiveCategory = (item == activeCategory);
                return GestureDetector(
                  onTap: () {
                    passRecipeCategory(item);
                    // recipeProvider.displayRecipes(
                    //     category: recipeProvider.categoryList![index]);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10),
                      child: Text(
                        // recipeProvider.categoryList![index],
                        item,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: (isActiveCategory)
                                ? Colors.white
                                : Colors.black),
                      ),
                      decoration: BoxDecoration(
                        color: (isActiveCategory)
                            ? Colors.black87
                            : Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        }
      },
    );
  }
}
