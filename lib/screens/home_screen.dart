import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_recipe_application/widgets/categories_list.dart';
import 'package:responsive_recipe_application/widgets/recipe_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
              child: CategoriesList(),
            ),

            //Recipes grid view
            RecipeGrid(),
            // const RecipeGrid(),

            //categories list
            // SliverList(
            //   delegate:
            //       SliverChildBuilderDelegate((BuildContext context, int index) {
            //     return Container(
            //       color: Colors.amber,
            //       height: 60.0,
            //       child: CategoriesList(),
            //     );
            //   }, childCount: 1),
            // )
          ],
        ),
      ),
    );
  }
}
