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

  Widget _mobileView(AsyncSnapshot snapshot) {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      scrollDirection: Axis.horizontal,
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
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                child: Text(
                  // recipeProvider.categoryList![index],
                  item,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: (isActiveCategory) ? Colors.white : Colors.black),
                ),
                decoration: BoxDecoration(
                  color:
                      (isActiveCategory) ? Colors.black87 : Colors.transparent,
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

  DropdownMenuItem<String> dropdownItems(String item) {
    return DropdownMenuItem<String>(
      value: item,
      child: Text(item),
    );
  }

  Widget _desktopView(AsyncSnapshot snapshot) {
    List<String> categoriesList = [...snapshot.data];
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Category',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 20),
          Container(
            height: 35,
            color: Colors.white70,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  value: activeCategory,
                  items: categoriesList.map(dropdownItems).toList(),
                  onChanged: (value) {
                    passRecipeCategory(value);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
          if (width > 480) {
            return _desktopView(snapshot);
          } else {
            return _mobileView(snapshot);
          }

          // return _mobileView(snapshot);
        }
      },
    );
  }
}
