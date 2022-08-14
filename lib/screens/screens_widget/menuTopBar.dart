import 'package:flutter/material.dart';
import 'package:klik/main/utils/AppWidget.dart';

import '../../main/utils/AppColors.dart';



class MenuTopBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 35),
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
    ),
    child: Image.asset('assets/images/beard.png'),
  );

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100);
}
