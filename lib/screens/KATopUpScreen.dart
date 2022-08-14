import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/extensions/WidgetExtension.dart';
import 'package:klik/main/models/topUpModel.dart';
import 'package:klik/main/provider/appProvider.dart';
import 'package:klik/screens/screens_widget/appText.dart';
import 'package:klik/screens/screens_widget/app_large_text.dart';
import 'package:klik/screens/screens_widget/colors.dart';
import 'package:klik/screens/screens_widget/generalTopBar.dart';
import 'package:klik/screens/top_up_modal.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../main/utils/AppWidget.dart';



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
      body: Consumer<PaymentProvider>(builder: (context, data, child){
        return data.isLoading?Center(
          child: Container(
            child: SpinKitThreeBounce(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: index.isEven ? Colors.red : Colors.green,
                  ),
                );
              },
            ),
          ),
        ):SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  25.height,
                  Align(
                    alignment: Alignment.topCenter,
                    child: buildTopUpTextWidget(),
                  ),
                  25.height,
                  Align(
                    alignment: Alignment.center,
                    child: buildTopUpAmountWidget(),
                  ),
                ],
              ),
            ),
          ),
        );
      },)
    );
  }
  Widget buildTopUpTextWidget()=> AppLargeText(text: "Top Up", color: AppColor.appMainColor,);
  Widget buildTopUpAmountWidget() => Container(
    height: 300,
    margin: const EdgeInsets.only(left: 35, right: 35),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: "Enter Amount", color: AppColor.appMainColor, size: 18,),
        Container(
          padding: const EdgeInsets.only(top: 16,  right: 15),
          child: shadowTextField( _amountController, '8890'),
        ),
        25.height,
        Container(
          padding: const EdgeInsets.only(top: 16,  right: 15),
          child: raisedButton(() {doPayment();}, 'Pay Now', MediaQuery.of(context).size.width, 50),
        ),
      ],
    ),
  );


  doPayment(){
    checkInput();
  }

  checkInput(){
    String amount = _amountController.text.toString();
    amount.isEmpty?alertDialog("Enter a valid amount"):sendAmount();
  }
  void sendAmount() async {
    const uuid = Uuid();
    int amount = int.parse(_amountController.text.toString());
    String currency = "NGN";
    String callbackUrl = "https://wavu-endpoint.herokuapp.com/api/topup";
    String redirectUrl = "https://wavu-endpoint.herokuapp.com/paymentresponse";
    final dashboardData = Provider.of<DashboardProvider>(context, listen: false);
    dashboardData.dashboardProvider();
    int userId = dashboardData.userDate!.profileDetails.userId;
    String referenceId = uuid.v1();
    List<Payload> payloadItem = [];

    // send reference id to endpoint
    var refProvider = Provider.of<RefProvider>(context, listen: false);
    refProvider.refProvider(referenceId);
    refProvider.isBack?print("sent"):print("failed");
    var payload = Payload(userId: userId, referenceId: referenceId);
    payloadItem.add(payload);
    print(payloadItem);

    //payment gateway response body


    var data = TopUpBody(referenceId: referenceId, amount: amount, currency: currency, callbackUrl: callbackUrl, redirectUrl: redirectUrl, payload: payloadItem);
    print('$referenceId, $amount, $currency');
    var provider = Provider.of<PaymentProvider>(context, listen: false);
    await provider.paymentProvider(data);
    if(provider.isBack){
      String webViewUrl = provider.topUpResponse!.url;
      print(webViewUrl);
        TopUpModalPage(url: webViewUrl).launch(context);
      //PaymentView(url: webViewUrl,).launch(context);
    }else{
      alertDialog("Something went wrong");
    }


  }
  alertDialog(String message){
    showDialog(
        context: context,
        builder: (context)=> AlertDialog(content: Text(message),));
  }
}
