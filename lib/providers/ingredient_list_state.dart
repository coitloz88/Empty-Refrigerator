import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:grocery_app/constants.dart';
import 'package:grocery_app/models/ingredient_item.dart';
import 'package:grocery_app/utils.dart';
import 'package:image_picker/image_picker.dart';

class IngredientListState with ChangeNotifier {
  late Uint8List _bytes;
  List<IngredientItem> _items = [];
  List<IngredientItem> _defaultItems = [];

  List<IngredientItem> get items => _items;
  List<IngredientItem> get defaultItems => _defaultItems;
  Uint8List get bytes => _bytes;

  void addItems(List<dynamic> newItems) {
    _items = newItems
        .asMap()
        .entries
        .map((e) => IngredientItem(id: e.key, name: e.value, checked: true))
        .toList();
    notifyListeners();
  }

  void addDefaultItems(List<dynamic> defaultItems) {
    _defaultItems = defaultItems
        .asMap()
        .entries
        .map<IngredientItem>(
            (e) => IngredientItem(id: e.key, name: e.value, checked: true))
        .toList();
    notifyListeners();
  }

  void toggle(index) {
    _items[index].checked = !_items[index].checked;
    notifyListeners();
  }
  
  void toggleDefault(index) {
    _defaultItems[index].checked = !_defaultItems[index].checked;
    notifyListeners();
  }

  void setBytes(String base64String) {
    _bytes = dataFromBase64String(base64String);
    notifyListeners();
  }

  Future fetchIngredientData(XFile imageFile) async {
    // 1. send picked image file to server
    Uint8List bytes = await imageFile.readAsBytes();
    String base64String = base64Encode(bytes);

    var url = Uri.http(serverUrl, 'detect');

    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({'image': base64String}));

      debugPrint(
          'fetchIngredientData response status code: ${response.statusCode}');
      debugPrint('fetchIngredientData response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future fetchDefaultIngredients() async {
    var url = Uri.http(serverUrl, 'list_ingredient');
    try {
      var response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future fetchRecipes(int k) async {
    var url = Uri.http(serverUrl, 'recipe');
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            'ingredient':
                _items.where((e) => e.checked).map((e) => e.name).toList(),
            'k': k
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
