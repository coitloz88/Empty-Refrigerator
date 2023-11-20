import 'package:grocery_app/models/ingredient_item.dart';

class RecipeItem {
  final int? id;
  final String title;
  final String url;

  List<IngredientItem> ingredients;

  RecipeItem(
      {this.id,
      required this.title,
      required this.ingredients,
      required this.url});
}

var recipeItemDemo = [
  RecipeItem(
      title: "김치볶음밥",
      ingredients: [
        IngredientItem(name: "김치"),
        IngredientItem(name: "밥"),
        IngredientItem(name: "스팸")
      ],
      url: "https://www.10000recipe.com/recipe/6881806"),
  RecipeItem(
      title: "간장계란밥",
      ingredients: [
        IngredientItem(name: "간장"),
        IngredientItem(name: "밥"),
        IngredientItem(name: "계란")
      ],
      url: "https://www.10000recipe.com/recipe/3687411"),
];
