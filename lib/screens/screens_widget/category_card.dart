import 'package:flutter/material.dart';

import 'appText.dart';
import 'colors.dart';


class CategoryWidget extends StatelessWidget {
  IconData icon;
  String categoryText;
  Color color;
  CategoryWidget({Key? key, required this.icon, required this.categoryText, this.color = const Color(0xFF3671F4)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: AppColor.appWhite,),
            const SizedBox(height: 5,),
            AppText(text: categoryText, color: AppColor.appWhite,),
          ],
        ),
      ),
    );
  }
}
