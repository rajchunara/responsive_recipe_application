class BriefRecipe {
  String strMeal;
  String strMealThumb;
  String idMeal;

  BriefRecipe(
      {required this.strMeal,
      required this.strMealThumb,
      required this.idMeal});

  factory BriefRecipe.fromJson(Map<String, dynamic> json) {
    return BriefRecipe(
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      idMeal: json['idMeal'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['strMeal'] = strMeal;
    data['strMealThumb'] = strMealThumb;
    data['idMeal'] = idMeal;
    return data;
  }

  @override
  String toString() {
    return "$strMeal $strMealThumb $idMeal";
  }
}
