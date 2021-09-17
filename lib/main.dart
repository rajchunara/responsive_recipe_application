import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_recipe_application/provider/recipe_provider.dart';
import 'package:responsive_recipe_application/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RecipeProvider>(create: (context)=>RecipeProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  HomeScreen(),
      ),
    );
  }
}
