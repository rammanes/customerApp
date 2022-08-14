
import 'package:flutter/material.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/extensions/WidgetExtension.dart';
import 'package:klik/main/models/pinModel.dart';
import 'package:klik/main/utils/AppColors.dart';

import '../main/utils/AppWidget.dart';



class KAPinGeneratedScreen extends StatelessWidget {
  final List<Pin> getPinList;
  KAPinGeneratedScreen({Key? key, required  this.getPinList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
            child: Column(
              children: [
                Expanded(child: Column(
                  children: [
                    buildPinGeneratedTop(),
                    25.height,
                    buildPinSuccessRows(),
                  ],
                )),
                buildCloseButton(context),
              ],
            ),
          )
    );
  }

  Widget  buildPinGeneratedTop()=> const Padding(
    padding:  EdgeInsets.only(top: 100, left: 25, right: 25),
    child: Text("Pins generated successfully!!!", textAlign: TextAlign.center, style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: appGreenColor
    ),)
  );
  
  Widget buildPinSuccessRows() => Container(
    padding: const EdgeInsets.only(left: 25, right: 25),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: getPinList.length,
      itemBuilder: (context, index){
        return Row(
          children: [
            Image.asset('assets/images/icons/pinButtonIcon.png', height: 30, width: 30,),
            15.width,
            Text(getPinList[index].pin.toString(), textAlign: TextAlign.center, style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: appLandingScreen
            ),)
          ],
        );
      })
  );

  Widget  buildCloseButton(BuildContext context) =>  Container(
    alignment: Alignment.bottomCenter,
    padding: const EdgeInsets.only(top: 45, bottom: 45),
    child: raisedButton(() {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }, 'Close', 200, 50),
  );
}
