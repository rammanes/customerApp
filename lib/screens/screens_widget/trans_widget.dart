import 'package:flutter/material.dart';
import 'package:klik/main/utils/AppColors.dart';

import 'appText.dart';

class TransWidget extends StatelessWidget {
  String date;
  String amount;
  String location;
  Color color;
  Color fontColor;
  TransWidget({Key? key, required this.date, required this.amount, this.location = "Nun Street, Maitama", required this.color, required this.fontColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: appShadowColor))
      ),
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color
                    ),
                  ),
                ],
              ),
              AppText(text: date, color: fontColor,),
              AppText(text: amount, color: fontColor,),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(width: 45,),
              const Icon(Icons.location_on_outlined, size: 16,),
              const SizedBox(width: 10,),
              AppText(text: location, color: fontColor,)
            ],
          )
        ],
      ),
    );
  }
}
