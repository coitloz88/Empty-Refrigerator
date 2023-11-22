import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/ingredient_item.dart';
import 'package:grocery_app/providers/ingredient_list_state.dart';
import 'package:grocery_app/providers/recipe_list_state.dart';
import 'package:grocery_app/screens/recipe/recipe_list_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:provider/provider.dart';

class IngredientListScreen extends StatefulWidget {
  @override
  State<IngredientListScreen> createState() => _IngredientListScreenState();
}

class _IngredientListScreenState extends State<IngredientListScreen> {
  bool fetching = false;
  int k = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/grocery_background.jpg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder: (context, setState) {
                          int maxNum = Provider.of<IngredientListState>(context,
                                  listen: false)
                              .items
                              .where((element) => element.checked)
                              .length;
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            insetPadding: EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              height: 550.0,
                              width: double.maxFinite,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(
                                            Icons.close,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(
                                    flex: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 45,
                                    ),
                                    child: Image(
                                        image: AssetImage(
                                            "assets/images/order_failed_image.png")),
                                  ),
                                  Spacer(
                                    flex: 2,
                                  ),
                                  AppText(
                                    text: "몇 개의 재료로 요리해볼까요?",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff7C7C7C),
                                  ),
                                  Spacer(
                                    flex: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (k > 1) --k;
                                            });
                                          },
                                          icon:
                                              Icon(Icons.chevron_left_outlined),
                                          color: k > 1
                                              ? Colors.grey[800]
                                              : Colors.grey[300]),
                                      AppText(
                                        text: k.toString(),
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            int maxNum = Provider.of<
                                                        IngredientListState>(
                                                    context,
                                                    listen: false)
                                                .items
                                                .where((element) =>
                                                    element.checked)
                                                .length;
                                            setState(() {
                                              if (k < maxNum) ++k;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.chevron_right_outlined,
                                            color: k < maxNum
                                                ? Colors.grey[800]
                                                : Colors.grey[300],
                                          ))
                                    ],
                                  ),
                                  Spacer(
                                    flex: 8,
                                  ),
                                  AppButton(
                                    label: "요리하기",
                                    fontWeight: FontWeight.w600,
                                    onPressed: () async {
                                      setState(() {
                                        fetching = true;
                                      });

                                      final dynamic response = await context
                                          .read<IngredientListState>()
                                          .fetchRecipes(k);

                                      if (response != null &&
                                          response.containsKey('recipes')) {
                                        context
                                            .read<RecipeListState>()
                                            .addItems(response['recipes']);
                                        Navigator.pop(context);

                                        // 페이지 이동
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RecipeListScreen()));

                                        setState(() {
                                          fetching = false;
                                        });
                                      }
                                    },
                                  ),
                                  Spacer(
                                    flex: 4,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      }).then((_) => {k = 1});
                  setState(() {
                    fetching = false;
                  });
                },
                child: SizedBox(
                    height: double.infinity,
                    child: Row(children: [
                      Center(
                          child: Text(
                        "요리하기",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                      )),
                      SizedBox(width: 12)
                    ])))
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
        body: !fetching
            ? SingleChildScrollView(
                child: Column(
                    children: context
                        .watch<IngredientListState>()
                        .items
                        .asMap()
                        .entries
                        .map((e) {
                  int index = e.key;
                  IngredientItem item = e.value;

                  return Padding(
                    padding: EdgeInsets.fromLTRB(16, 6, 16, 4),
                    child: Row(
                      children: [
                        Checkbox(
                            fillColor: MaterialStateProperty.all(
                                AppColors.primaryColor),
                            value: item.checked,
                            onChanged: (value) {
                              context.read<IngredientListState>().toggle(index);
                            }),
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
              )
            : Center(
                child: SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              )),
      ),
    );
  }
}
