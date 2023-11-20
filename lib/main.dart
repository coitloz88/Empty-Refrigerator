import 'package:flutter/material.dart';
import 'package:grocery_app/providers/bbox_state.dart';
import 'package:grocery_app/providers/ingredient_checked_state.dart';
import 'package:grocery_app/providers/ingredient_list_state.dart';
import 'package:grocery_app/providers/recipe_list_state.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => BboxState()),
    ChangeNotifierProvider(create: (_) => IngredientListState()),
    ChangeNotifierProvider(create: (_) => IngredientCheckedState()),
    ChangeNotifierProvider(create: (_) => RecipeListState()),
  ], child: MyApp()));
}
