import 'package:flutter/material.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/utils/AppWidget.dart';
import 'package:klik/screens/screens_widget/generalTopBar.dart';

import '../main/utils/AppColors.dart';
import '../main/utils/AppUtils.dart';


class KAPaymentScreen extends StatefulWidget {
  final String topUpAmt;
  const KAPaymentScreen({Key? key, required this.topUpAmt}) : super(key: key);

  @override
  State<KAPaymentScreen> createState() => _KAPaymentScreenState();
}

class _KAPaymentScreenState extends State<KAPaymentScreen> {
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
        child:Padding(
          padding: const EdgeInsets.only(left: 45, right: 45),
          child: ListView(
            children: [
              15.height,
              buildPaymentTextWidget(),
              buildAmountWidget(),
              15.height,
              buildActivityWidget("Credit card number", _cardNum, "*********** 5676"),
              buildActivityWidget("Name on card", _cardName, "Rolland Kelly"),
              5.height,
              buildCardDetailsWidget(),
              25.height,
             buildHistoryWidget(),
              10.height,
              buildPaymentButton(),
              10.height,
              buildOptionWidget()
            ],
          ),
        ),
      )
    );
  }

  Widget buildOptionWidget() => const Text("Select another card?", textAlign: TextAlign.left, style:TextStyle(
      fontWeight: FontWeight.w500,
      color: appLandingScreen
  ),);
  Widget buildPaymentButton()=>  Container(
    alignment: Alignment.bottomCenter,
    padding: const EdgeInsets.only(top: 2),
    child: raisedButton(() => null, 'Pay Now', 300, 50),
  );

  Widget buildHistoryWidget() =>Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text("Save card for future transactions", textAlign: TextAlign.left, style:TextStyle(
          fontWeight: FontWeight.w500,
          color: appLandingScreen
      ),),
      Checkbox(
        value: this.value,
        onChanged: (bool? value) {
          setState(() {
            this.value = value!;
          });
        },
      ), //Checkbox
    ],
  );

  Widget buildActivityWidget(String txtDetails, TextEditingController controller, String hintText) => Column(
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
  );
  Widget buildAmountWidget() => Container(
    height: Utility(context).height * 0.065,
    alignment: Alignment.center,
    child: RichText(
            text: TextSpan(
                text: "NGN  ",
                style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.topUpAmt,
                    style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w500),
                  )
                ]),
          ),
  );
  Widget buildPaymentTextWidget() => Container(
    width: double.infinity,
    child: const Text("Payment", textAlign: TextAlign.center, style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: appLandingScreen
    ),),
  );

  Widget buildCardDetailsWidget() => Row(
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
  );
}
