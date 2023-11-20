import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/helpers/column_with_seprator.dart';
import 'package:grocery_app/models/ingredient_item.dart';
import 'package:grocery_app/models/recipe_item.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeItem item;

  const RecipeDetailScreen({super.key, required this.item});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
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
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: AppText(
            text: widget.item.title,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: getChildrenWithSeperator(
                  addToLastChild: false,
                  widgets: [
                    getUrlWidget(widget.item.url),
                    getIngredientsWrapper(widget.item.ingredients)
                  ],
                  seperator: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getUrlWidget(String url) {
    return Padding(
        padding: EdgeInsets.all(12),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                  text: "레시피 URL은 여기로!",
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
              SizedBox(height: 4),
              ListTile(leading: Icon(Icons.link), title: Text(url))
            ]));
  }

  Widget getIngredientsWrapper(List<IngredientItem> items) {
    return Padding(
        padding: EdgeInsets.all(12),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                  text: "필요한 재료들", fontWeight: FontWeight.w600, fontSize: 16),
              SizedBox(height: 4),
              Column(
                children: items.map((item) {
                  return ListTile(title: Text('- ' + item.name));
                }).toList(),
              )
            ]));
  }
}
