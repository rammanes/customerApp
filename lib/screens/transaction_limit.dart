import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/models/WAModel.dart';
import 'package:klik/screens/main_page.dart';
import 'package:klik/screens/screens_widget/appText.dart';
import 'package:klik/screens/screens_widget/app_large_text.dart';
import 'package:klik/screens/screens_widget/colors.dart';
import 'package:klik/screens/screens_widget/generalTopBar.dart';
import 'package:provider/provider.dart';

import '../main/provider/appProvider.dart';
import '../main/utils/AppWidget.dart';


class TransLimitPage extends StatefulWidget {
  final int cardId;
  TransLimitPage({Key? key, required this.cardId}) : super(key: key);

  @override
  State<TransLimitPage> createState() => _TransLimitPageState();
}

class _TransLimitPageState extends State<TransLimitPage> {
  TextEditingController _dailyController = TextEditingController();
  int limitAmt = 0;
  int monthlyLimit =0;
  int weeklyLimit =0;
  @override
  void initState(){
    super.initState();
    _dailyController.addListener(() {
        _doMath();
    });
  }
  @override
  void dispose(){
    _dailyController.dispose();
    super.dispose();
  }
  _doMath(){
    setState((){
      limitAmt = int.parse(_dailyController.text.toString());
      monthlyLimit = 30 * limitAmt;
      weeklyLimit = 7 * limitAmt;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralTopBar(),
      body: Consumer<CardLimitProvider>(builder:(context, data, child){
        return data.isLoading ? Center(
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
        ):SingleChildScrollView(
          child: Column(
            children: [
              25.height,
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: AppLargeText(text: "Transaction limit", size: 22, color: AppColor.appMainColor,),
              ),
              25.height,
              Center(
                child: Align(
                    alignment: Alignment.center,
                    child: AppText(text: "limit your card transactions to avoid misuse", size: 16, color: AppColor.appMainColor,)),
              ),
              40.height,
              Container(
                height: 82,
                color: AppColor.appHazy,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppText(text: "Daily Transaction Limit", color: AppColor.appMainColor,),
                      AppLargeText(text: "NGN", color: Colors.black87, size: 22,),
                      Card(
                        elevation: 2,
                        child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 120,
                            child: TextFormField(
                              controller: _dailyController,
                              // onChanged: _doMath(),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: "N/A"),
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ),
              10.height,
              buildLimitWidget("Weekly Transaction Limit", weeklyLimit.toString()),
              10.height,
              buildLimitWidget("Monthly Transaction Limit", monthlyLimit.toString()),
              50.height,
              Container(
                padding: const EdgeInsets.only(top: 16,  left: 35, right: 35),
                child: raisedButton(() {
                  setLimit();
                }, 'Save', MediaQuery.of(context).size.width, 50),
              ),
            ],
          ),
        );
      })
    );
  }
  Widget buildLimitWidget(String txt, String secTxt ) =>  Container(
    height: 82,
    color: AppColor.appHazy,
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppText(text: txt, color: AppColor.appMainColor,),
          AppLargeText(text: "NGN", color: Colors.black87, size: 22,),
          Card(
            elevation: 2,
            child: Container(
                padding: const EdgeInsets.only(left: 15, bottom: 11, top: 12, right: 15),
                height: 50,
                width: 120,
                child: AppLargeText(text: secTxt, color: Colors.black87, size: 20,)
            ),
          )
        ],
      ),
    ),
  );

  setLimit(){
    checkInput();
  }

  checkInput(){
    String  amount = _dailyController.text.toString();
    amount.isEmpty?alertDialog("Enter a valid amount"):doLimit();
  }

  void doLimit() async{
    int amount = int.parse(_dailyController.text.toString());
    var cardLimit = CardLimit(dailyLimit: amount.toString(), monthlyLimit: monthlyLimit.toString());
    print(cardLimit.toJson());
    var limitProvider = Provider.of<CardLimitProvider>(context, listen: false);
    await limitProvider.cardLimitProvider(cardLimit, widget.cardId);
    if(limitProvider.isBack){
      alertDialog("message");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> MainPage()), (route) => false);
    }else{
      alertDialog("Transaction Failed");
    }
  }
  alertDialog(String message){
    showDialog(
        context: context,
        builder: (context)=> AlertDialog(content: Text(message),));
  }
}
