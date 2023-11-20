import 'package:flutter/material.dart';
import 'package:grocery_app/models/ingredient_item.dart';

class IngredientListState extends ChangeNotifier {
  List<IngredientItem> _items = [];
  
  List<IngredientItem> get items => _items;

  void addItems(List<IngredientItem> newItems) {
    _items = newItems;
    notifyListeners();
  }
}