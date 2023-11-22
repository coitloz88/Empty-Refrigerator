import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/providers/ingredient_checked_state.dart';
import 'package:grocery_app/providers/ingredient_list_state.dart';
import 'package:grocery_app/screens/ingredient/bbox_display_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final String imagePath = "assets/images/welcome_image.jpeg";
  final ImagePicker picker = ImagePicker();

  bool fetching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: !fetching
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Spacer(),
                        icon(),
                        SizedBox(
                          height: 20,
                        ),
                        welcomeTextWidget(),
                        SizedBox(
                          height: 16,
                        ),
                        sloganText(),
                        SizedBox(
                          height: 40,
                        ),
                        getCameraButton(context),
                        SizedBox(
                          height: 16,
                        ),
                        getGalleryButton(context),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    )
                  : SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(),
                    )),
        ));
  }

  Widget icon() {
    String iconPath = "assets/icons/app_icon.svg";
    return SvgPicture.asset(
      iconPath,
      width: 48,
      height: 56,
    );
  }

  Widget welcomeTextWidget() {
    return Column(
      children: [
        AppText(
          text: "냉장고를",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        AppText(
          text: "털어보자",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget sloganText() {
    return AppText(
      text: "냉털냉털 지금 바로 털어보아요",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color(0xffFCFCFC).withOpacity(0.7),
    );
  }

  Widget getCameraButton(BuildContext context) {
    return AppButton(
      label: "카메라로 찍기",
      fontWeight: FontWeight.w600,
      padding: EdgeInsets.symmetric(vertical: 25),
      trailingWidget: Icon(Icons.camera_alt),
      onPressed: () {
        getImage(context, ImageSource.camera);
      },
    );
  }

  Widget getGalleryButton(BuildContext context) {
    return AppButton(
      label: "갤러리에서 가져오기",
      fontWeight: FontWeight.w600,
      padding: EdgeInsets.symmetric(vertical: 25),
      trailingWidget: Icon(Icons.photo),
      onPressed: () {
        getImage(context, ImageSource.gallery);
      },
    );
  }

  Future getImage(BuildContext context, ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        fetching = true;
      });

      final dynamic response = await context
          .read<IngredientListState>()
          .fetchIngredientData(pickedFile);

      if (response != null &&
          response.containsKey('bbox') &&
          response.containsKey('ingredient')) {
        context.read<IngredientListState>().setBytes(response['bbox']);
        context.read<IngredientListState>().addItems(response['ingredient']);

        // 페이지 이동
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BboxDisplayScreen(
                      base64String: response['bbox'],
                    )));

        setState(() {
          fetching = false;
        });
      }
    }
  }
}
