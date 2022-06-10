import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/extensions/WidgetExtension.dart';
import 'package:klik/main/models/MPOptionsModel.dart';
import 'package:klik/main/provider/MPOptionsProvider.dart';
import 'package:klik/screens/screens_widget/generalTopBar.dart';

import '../main/utils/AppColors.dart';
import '../main/utils/AppWidget.dart';
import 'KAPaymentGateWay.dart';


class KAPayOptions extends StatefulWidget {

  @override
  State<KAPayOptions> createState() => _KAPayOptionsState();
}

class _KAPayOptionsState extends State<KAPayOptions> {
  List<PaymentOptions> cardList = [];

  @override
  void initState() {
    super.initState();
    cardList = getCardType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralTopBar(),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
        child: SingleChildScrollView(
          child: Container(
            height: 300,
            child: Column(
              children: [
                buildPayOptionsWidget(),
                15.height,
                buildOptionsButton(),
                10.height,
                InkWell(
                  onTap: (){
                    KAPaymentGateScreen().launch(context);
                  },
                  child: buildSettingsItems('assets/images/icons/selectedMgd.png')),
                buildSettingsItems('assets/images/icons/unselectedMgd.png')
               
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildSettingsItems(String imageUrl) => Container(
    height: 70,
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
    child: Image.asset(imageUrl, fit: BoxFit.fill,),
  );

  Widget  buildPayOptionsWidget() => const Text("Manage Payment Options", textAlign: TextAlign.center, style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: appLandingScreen
  ),);

  Widget buildCurrentCardWidget() => Container(
    height: 70,
    width: double.infinity,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/selectedBg.png'),
        fit: BoxFit.cover
      )
    ),
  );

  Widget  buildOptionalCardWidget() => Container(
    height: 70,
    width: double.infinity,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/unselectedBg.png'),
            fit: BoxFit.cover
        )
    ),
  );

  Widget buildOptionsButton() =>  Container(
    alignment: Alignment.topRight,
    padding: const EdgeInsets.only(top: 45),
    child: raisedButton(() => null, '+ Add card', 150, 50),
  );

  bool checkIndex(int index) {
    print(index);
    return (index.compareTo(1)==0) ;
  }
}
