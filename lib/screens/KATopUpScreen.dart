import 'package:flutter/material.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/extensions/WidgetExtension.dart';
import 'package:klik/main/utils/AppColors.dart';
import 'package:klik/screens/screens_widget/generalTopBar.dart';

import '../main/utils/AppWidget.dart';
import 'KAPaymentScreen.dart';


class KATopUpScreen extends StatefulWidget {
  const KATopUpScreen({Key? key}) : super(key: key);

  @override
  State<KATopUpScreen> createState() => _KATopUpScreenState();
}

class _KATopUpScreenState extends State<KATopUpScreen> {
  TextEditingController _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralTopBar(),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            buildTopUpTextWidget(),
            35.height,
            buildDetailsWidget("Available balance", "NGN", "2000.00"),
            buildDetailsWidget("Charges", "NGN", "2000.00"),
            buildDetailsWidget("Balance after payment", "NGN", "2,000,000.00"),
            25.height,
            Expanded(child: buildTopUpAmountWidget()),
            buildTopUpButton(),
          ],
        ),
      )
    );
  }
  Widget buildTopUpTextWidget()=> Container(
    width: double.infinity,
    child: const Text("Top Up", textAlign: TextAlign.center, style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: appLandingScreen
    ),),
  );
  Widget buildDetailsWidget(String detailTxt, String nairaTxt, String balanceTxt) => Padding(
    padding: const EdgeInsets.only(left:25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.39,
          child: Text(detailTxt, style: TextStyle(fontSize: 14, color: appLandingScreen), textAlign: TextAlign.left,),
        ),
        10.width,
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.18,
          child: Text(nairaTxt, style: TextStyle(fontSize: 18, color: appLandingScreen, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
        ),
        Container(
          height: 60,
          child: Expanded(child: Text(balanceTxt, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500), textAlign: TextAlign.left,)),
        ),

      ],
    ),
  );

  Widget buildTopUpAmountWidget() => Padding(
    padding: const EdgeInsets.only(left: 35, right: 35),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 40),
          child: const Text('Enter TopUp Amount', style: TextStyle(
              fontWeight: FontWeight.w500,
              color: appLandingScreen
          ),),
        ),
        Container(
          padding: const EdgeInsets.only(top: 16, left: 15, right: 15),
          child: shadowTextField( _amountController, '8890'),
        ),
      ],
    ),
  );

  Widget buildTopUpButton()=> Container(
    alignment: Alignment.bottomCenter,
    padding: const EdgeInsets.only(top: 45, bottom: 45),
    child: raisedButton(() {
      KAPaymentScreen().launch(context);
    }, 'Pay Now', 200, 50),
  );
}
