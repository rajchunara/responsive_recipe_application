import 'package:responsive_recipe_application/models/brief_recipe.dart';

class DetailedRecipe extends BriefRecipe {
  String strCategory;
  String strArea;
  String strInstructions;
  String strMeal;
  String strMealThumb;
  String idMeal;
  String? strTags;
  Map<String, String>? ingridentsList;

  DetailedRecipe(
      {this.strMeal = '',
      this.strMealThumb = '',
      this.idMeal = '',
      this.strArea = '',
      this.strCategory = '',
      this.strInstructions = '',
      this.strTags = ''})
      : super(strMeal: strMeal, strMealThumb: strMealThumb, idMeal: idMeal);

  factory DetailedRecipe.fromJson(Map<String, dynamic> json) {
    return DetailedRecipe(
        strMeal: json['strMeal'],
        strMealThumb: json['strMealThumb'],
        idMeal: json['idMeal'],
        strArea: json['strArea'],
        strCategory: json['strCategory'],
        strInstructions: json['strInstructions'],
        strTags: json['strTags'] ?? '');
  }
}
