import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/ingredient_item.dart';
import 'package:grocery_app/providers/ingredient_list_state.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:provider/provider.dart';

class DefaultIngredientListTab extends StatefulWidget {
  @override
  State<DefaultIngredientListTab> createState() =>
      _DefaultIngredientListTabState();
}

class _DefaultIngredientListTabState extends State<DefaultIngredientListTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            children: context
                .watch<IngredientListState>()
                .defaultItems
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
                fillColor: MaterialStateProperty.all(AppColors.primaryColor),
                value: item.checked,
                onChanged: (value) {
                  context.read<IngredientListState>().toggleDefault(index);
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
    }).toList()));
  }
}
