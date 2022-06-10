import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/utils/AppColors.dart';



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
            buildAppProfileAvatar()
          ],
        ),
      )
    );
  }
  Widget buildAppProfileAvatar() => Container(
    height: 60,
    width: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      boxShadow: const [
        BoxShadow(
          color: appTextColorSecondary,
        )
      ]
    ),
  );

  Widget buildAppMerchant() {
    return Row(
      children: [
        buildAppProfileAvatar(),
        12.width,
        buildText(),
      ],
    );
  }
  Widget buildText() => const Text("MERCHANT", style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: appUIDarker
  ),);
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100);
}
