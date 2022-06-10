import 'package:flutter/material.dart';
import 'package:klik/main/utils/AppWidget.dart';

import '../../main/utils/AppColors.dart';



class BackTopBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 35),
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: backButton(context),
              ),
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

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100);
}
