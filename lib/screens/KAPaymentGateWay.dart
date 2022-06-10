import 'package:flutter/material.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/screens/screens_widget/generalTopBar.dart';

import '../main/utils/AppColors.dart';
import '../main/utils/AppWidget.dart';


class KAPaymentGateScreen extends StatefulWidget {
  const KAPaymentGateScreen({Key? key}) : super(key: key);

  @override
  State<KAPaymentGateScreen> createState() => _KAPaymentGateScreenState();
}

class _KAPaymentGateScreenState extends State<KAPaymentGateScreen> {
  TextEditingController _cardNum = TextEditingController();
  TextEditingController _cardName = TextEditingController();
  TextEditingController _expDate = TextEditingController();
  TextEditingController _cardCvv= TextEditingController();
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GeneralTopBar(),
        body: SafeArea(
          child:ListView(
            children: [
              15.height,
              buildPaymentTextWidget(),
              15.height,
              buildCardContainer(),
              15.height,
              buildActivityWidget("Credit card number", _cardNum, "*********** 5676"),
              buildActivityWidget("Name on card", _cardName, "Rolland Kelly"),
              5.height,
              buildCardDetailsWidget(),
              25.height,
              buildPaymentButton(),
            ],
          ),
        )
    );
  }
  Widget buildCardContainer() => Container(
   margin: const EdgeInsets.only(left: 45, right: 45),
    height: 165,
    width: 280,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/containerBg.png'), fit: BoxFit.fill
      )
    ),
  );
  Widget buildPaymentButton()=>  Container(
    alignment: Alignment.bottomCenter,
    padding: const EdgeInsets.only(top: 2),
    child: raisedButton(() => null, 'Save', 300, 50),
  );


  Widget buildActivityWidget(String txtDetails, TextEditingController controller, String hintText) => Padding(
    padding: const EdgeInsets.only(left: 35, right: 35),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 15),
          width: double.infinity,
          child:  Text(txtDetails, textAlign: TextAlign.left, style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: appLandingScreen
          ),),
        ),
        Container(
          padding: const EdgeInsets.only(top: 16,),
          child: shadowTextField( controller, hintText),
        ),
      ],
    ),
  );

  Widget buildPaymentTextWidget() => Container(
    width: double.infinity,
    child: const Text("Manage payment options", textAlign: TextAlign.center, style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500,
        color: appLandingScreen
    ),),
  );

  Widget buildCardDetailsWidget() => Padding(
    padding: const EdgeInsets.only(left: 35,right: 35),
    child: Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 25),
                  child: const Text('Exp. Date', textAlign: TextAlign.left, style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: appLandingScreen
                  ),),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: shadowTextField( _expDate, '12/24'),
                ),
              ],
            ),
          ),
          25.width,
          Expanded(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 25),
                  child: const Text('CVV', textAlign: TextAlign.left, style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: appLandingScreen
                  ),),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: shadowTextField( _cardCvv, '589'),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
