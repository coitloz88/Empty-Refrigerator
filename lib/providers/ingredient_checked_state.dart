import 'package:flutter/material.dart';

class IngredientCheckedState extends ChangeNotifier {
  Map<int, bool> _isChecked = {};

  Map<int, bool> get isChecked => _isChecked;

  void toggle(int id) {
    if (_isChecked[id] != null) {
      _isChecked[id] = !_isChecked[id]!;
    } else {
      _isChecked[id] = true;
    }
    notifyListeners();
  }

  void add(int id) {
    _isChecked[id] = true;
    notifyListeners();
  }
}
