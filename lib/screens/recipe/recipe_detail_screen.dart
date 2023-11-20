import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/helpers/column_with_seprator.dart';
import 'package:grocery_app/models/ingredient_item.dart';
import 'package:grocery_app/models/recipe_item.dart';
import 'package:url_launcher/url_launcher.dart';

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
        padding: EdgeInsets.fromLTRB(24, 20, 24, 10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                  text: "레시피 링크",
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
              SizedBox(height: 4),
              ListTile(
                leading: Icon(Icons.link),
                title: Text(url),
                onTap: () {
                  launchUrl(Uri.parse(url));
                },
              )
            ]));
  }

  Widget getIngredientsWrapper(List<IngredientItem> items) {
    final List<IconData> iconDatas = [
      Icons.egg_alt,
      Icons.local_pizza,
      Icons.lunch_dining,
      Icons.icecream,
      Icons.breakfast_dining_outlined,
      Icons.bento
    ];

    return Padding(
        padding: EdgeInsets.fromLTRB(24, 20, 24, 10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                  text: "필요한 재료들", fontWeight: FontWeight.w600, fontSize: 16),
              SizedBox(height: 12),
              Column(
                children: items.asMap().entries.map<Widget>((e) {
                  int index = e.key;
                  IngredientItem item = e.value;
                  return ListTile(
                      leading: Icon(iconDatas[index % iconDatas.length]),
                      title: Text(item.name));
                }).toList(),
              )
            ]));
  }
}
