import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:core';

class CategoriesList extends StatefulWidget {
  CategoriesList({Key? key}) : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  Future<List<String>> _getAllCategories() async {
    const String _categoriesListURL =
        "https://www.themealdb.com/api/json/v1/1/list.php?c=list";
    var url = Uri.parse(_categoriesListURL);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable catgList = result["meals"];
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getAllCategories(),
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
                return GestureDetector(
                  onTap: () {
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
                        style: const TextStyle(
                            fontSize: 15.0, color: Colors.black),
                      ),
                      decoration: const BoxDecoration(
                        // color: (recipeProvider.categorySelected ==
                        //         recipeProvider.categoryList![index])
                        //     ? Colors.black87
                        //     : Colors.grey,
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
