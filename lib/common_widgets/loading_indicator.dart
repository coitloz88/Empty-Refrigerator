import 'package:flutter/material.dart';
import 'package:grocery_app/styles/colors.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 150,
      height: 150,
      child: CircularProgressIndicator(color: AppColors.primaryColor),
    ));
  }
}
