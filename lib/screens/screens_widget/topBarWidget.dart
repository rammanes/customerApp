import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/utils/AppColors.dart';
import 'package:klik/screens/screens_widget/app_large_text.dart';
import 'package:klik/screens/screens_widget/colors.dart';



class TopBarWidget extends StatelessWidget implements PreferredSizeWidget{

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 35),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildAppMerchant(),
            buildAppProfileAvatar("assets/images/beard.png")
          ],
        ),
      )
    );
  }
  Widget buildAppProfileAvatar(String imageUrl) => Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
      shape: BoxShape.circle
    ),
    child: imageUrl.isEmpty? Container(): Image.asset(imageUrl, height: 40, width: 40,) ,
  );

  Widget buildAppMerchant() {
    return Row(
      children: [
        buildAppProfileAvatar('assets/images/merchantLogo.png'),
        12.width,
        buildText(),
      ],
    );
  }
  Widget buildText() => AppLargeText(text: "AARANO", size: 20, color: AppColor.appMainColor,);
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100);
}
