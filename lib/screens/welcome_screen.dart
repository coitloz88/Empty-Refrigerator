import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/screens/ingredient/bbox_display_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final String imagePath = "assets/images/welcome_image.jpeg";
  XFile? _image;
  final ImagePicker picker = ImagePicker();

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
            child: Column(
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
            ),
          ),
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
      // TODO: 서버와 통신 후 넘어가도록 or 로딩 화면으로 넘어가도록 함
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BboxDisplayScreen(
                    imagePath: pickedFile.path,
                  )));
    }
  }
}
