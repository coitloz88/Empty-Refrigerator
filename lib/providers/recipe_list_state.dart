import 'package:flutter/material.dart';
import 'package:grocery_app/models/recipe_item.dart';

class RecipeListState extends ChangeNotifier {
  List<RecipeItem> _items = [];
  
  List<RecipeItem> get items => _items;

  void addItems(List<RecipeItem> newItems) {
    _items = newItems;
    notifyListeners();
  }
}