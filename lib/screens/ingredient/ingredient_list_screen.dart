import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/screens/cart/cart_screen.dart';
import 'package:grocery_app/screens/explore_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:grocery_app/widgets/grocery_item_card_widget.dart';

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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ExploreScreen()));
              },
              child: 
              SizedBox(height: double.infinity, child: Padding(padding: EdgeInsets.all(12), child: Center(child: Text(
                "요리하기",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor),
              ))),)
              )
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
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          // I only need two card horizontally
          children: demoItems.asMap().entries.map<Widget>((e) {
            GroceryItem groceryItem = e.value;
            return GestureDetector(
              onTap: () {
                onItemClicked(context, groceryItem);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: GroceryItemCardWidget(
                  item: groceryItem,
                  heroSuffix: "explore_screen",
                ),
              ),
            );
          }).toList(),
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 0.0, // add some space
        ),
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
