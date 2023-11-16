import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/styles/colors.dart';

class BboxDisplayScreen extends StatelessWidget {
  final String imagePath;

  const BboxDisplayScreen({super.key, required this.imagePath}); // TODO: 서버에서 응답 받은 이미지로 변경

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkGrey,
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [AppButton(label: '리스트로 보기'), SizedBox(height: 20)],
              ),
            )));
  }
}
