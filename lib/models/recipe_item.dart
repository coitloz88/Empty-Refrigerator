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
        IngredientItem(checked: true, name: "김치"),
        IngredientItem(checked: true, name: "밥"),
        IngredientItem(checked: true, name: "스팸")
      ],
      url: "https://www.10000recipe.com/recipe/6881806"),
  RecipeItem(
      title: "간장계란밥",
      ingredients: [
        IngredientItem(checked: true, name: "간장"),
        IngredientItem(checked: true, name: "밥"),
        IngredientItem(checked: true, name: "계란")
      ],
      url: "https://www.10000recipe.com/recipe/3687411"),
];
