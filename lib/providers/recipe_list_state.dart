import 'package:flutter/material.dart';
import 'package:grocery_app/models/ingredient_item.dart';
import 'package:grocery_app/models/recipe_item.dart';

class RecipeListState with ChangeNotifier {
  List<RecipeItem> _items = [];

  List<RecipeItem> get items => _items;

  void addItems(List<dynamic> newItems) {
    debugPrint(newItems.toString());
    _items = newItems.map((e) {
      List<IngredientItem> ingredients = e['ingredient']
          .asMap()
          .entries
          .map<IngredientItem>((ingredient) => IngredientItem(
              checked: true, id: ingredient.key, name: ingredient.value))
          .toList();

      return RecipeItem(
          title: e['title'], ingredients: ingredients, url: e['url']);
    }).toList();
    notifyListeners();
  }
}
