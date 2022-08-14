import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/utils/AppColors.dart';
import 'package:klik/main/utils/AppWidget.dart';
import 'package:klik/screens/screens_widget/appText.dart';
import 'package:klik/screens/screens_widget/app_large_text.dart';
import 'package:klik/screens/screens_widget/colors.dart';
import 'package:klik/screens/screens_widget/generalTopBar.dart';

class CreditCardPage extends StatefulWidget {
  final String topUpAmt;

  const CreditCardPage({Key? key, required this.topUpAmt}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CreditCardPageState();
  }
}

class CreditCardPageState extends State<CreditCardPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool value = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(

          children: <Widget>[
            10.height,
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: backButton(context),
                ),
                Expanded(child: Container(
                  child: AppText(text: "Top up amount NGN ${widget.topUpAmt}", color: Colors.black87, size: 20,),
                )),
              ],
            ),
            CreditCardWidget(
              cardBgColor: appBlueWidget,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true, onCreditCardWidgetChange: (CreditCardBrand) {  },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    CreditCardForm(
                      formKey: formKey,
                      onCreditCardModelChange: onCreditCardModelChange,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumberDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',

                      ),
                      cvvCodeDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Card Holder Name',
                      ), expiryDate: '', cardNumber: '', cvvCode: '', themeColor: appLandingScreen, cardHolderName: '',
                    ),
                    5.height,
                    buildHistoryWidget(),
                    5.height,
                    Container(
                      padding: const EdgeInsets.only(top: 16, left: 15, right: 15),
                      child: raisedButton(() {
                        if (formKey.currentState!.validate()) {
                          var cardDetails = CreditCardModel(cardNumber, expiryDate, cardHolderName, cvvCode, isCvvFocused);
                          print(cardDetails.cardHolderName);
                        } else {
                          print('invalid!');
                        }
                      }, 'Pay Now', MediaQuery.of(context).size.width, 50),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildHistoryWidget() =>Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: Row(
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
    ),
  );
  _showValidDialog(BuildContext context, String title, String content,) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff1b447b),
          title: Text(title),
          content: Text(content),
          actions: [
            FlatButton(
                child: Text(
                  "Ok",
                  style: TextStyle(fontSize: 18,color: Colors.cyan),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );

      },
    );
  }


  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}