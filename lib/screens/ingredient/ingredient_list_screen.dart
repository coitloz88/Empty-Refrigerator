import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/models/ingredient_item.dart';
import 'package:grocery_app/screens/recipe/recipe_list_screen.dart';
import 'package:grocery_app/styles/colors.dart';

class IngredientListScreen extends StatefulWidget {
  @override
  State<IngredientListScreen> createState() => _IngredientListScreenState();
}

class _IngredientListScreenState extends State<IngredientListScreen> {
  // List<bool> isAdded = List<bool>.generate(demoItems.length, (index) => true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.only(left: 25),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecipeListScreen()));
              },
              child: SizedBox(
                height: double.infinity,
                child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Center(
                        child: Text(
                      "요리하기",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor),
                    ))),
              ))
        ],
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: AppText(
            text: "냉장고 속 재료들",
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: ingredientItemDemo.map((item) {
          return Padding(
            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Row(
              children: [
                Checkbox(value: true, onChanged: (value) {}),
                Expanded(
                  child: AppText(
                    text: item.name,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }).toList()),
      ),
    );
  }

  void onItemClicked(BuildContext context, GroceryItem groceryItem) {
    // TODO: Provider 배열의 element 상태 변경
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ProductDetailsScreen(
    //       groceryItem,
    //       heroSuffix: "explore_screen",
    //     ),
    //   ),
    // );
  }
}
