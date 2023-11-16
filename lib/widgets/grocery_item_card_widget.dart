import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/styles/colors.dart';

class GroceryItemCardWidget extends StatefulWidget {
  GroceryItemCardWidget({Key? key, required this.item, this.heroSuffix})
      : super(key: key);
  final GroceryItem item;
  final String? heroSuffix;

  @override
  State<GroceryItemCardWidget> createState() => _GroceryItemCardWidgetState();
}

class _GroceryItemCardWidgetState extends State<GroceryItemCardWidget> {
  final double width = 174;

  final double height = 250;

  final Color borderColor = Color(0xffE2E2E2);

  final double borderRadius = 18;

  bool isAdded = true; // TODO: Provider로 변경

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Hero(
                  tag: "GroceryItem:" +
                      widget.item.name +
                      "-" +
                      (widget.heroSuffix ?? ""),
                  child: imageWidget(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AppText(
              text: widget.item.name,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            AppText(
              text: widget.item.description,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7C7C7C),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                AppText(
                  text: "추가하기",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                Spacer(),
                Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0))),
                        activeColor: AppColors.primaryColor,
                        value: isAdded,
                        onChanged: (value) {
                          isAdded = value!;
                        }))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      child: Image.asset(widget.item.imagePath),
    );
  }
}
