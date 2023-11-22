import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/screens/ingredient/ingredient_list_screen.dart';
import 'package:grocery_app/styles/colors.dart';

class BboxDisplayScreen extends StatefulWidget {
  final String base64String;

  const BboxDisplayScreen({super.key, required this.base64String});

  @override
  State<BboxDisplayScreen> createState() => _BboxDisplayScreenState();
}

class _BboxDisplayScreenState extends State<BboxDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkGrey,
        body: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.8,
                        fit: BoxFit.cover,
                        image: AssetImage(
                            'assets/images/grocery_background.jpg')))),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(base64Decode(widget.base64String)),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppButton(
                        label: '리스트로 보기',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      IngredientListScreen()));
                        },
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                )),
          ],
        ));
  }
}
