import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grocery_app/models/ingredient_item.dart';
import 'package:grocery_app/utils.dart';

class IngredientListState with ChangeNotifier {
  late Uint8List _bytes;
  List<IngredientItem> _items = [];

  List<IngredientItem> get items => _items;
  Uint8List get bytes => _bytes;

  void addItems(List<IngredientItem> newItems) {
    _items = newItems;
    notifyListeners();
  }

  void setBytes(String base64String) {
    _bytes = dataFromBase64String(base64String);
    notifyListeners();
  }
}
