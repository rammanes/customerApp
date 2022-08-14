import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/extensions/WidgetExtension.dart';
import 'package:klik/main/provider/appProvider.dart';
import 'package:klik/screens/screens_widget/appText.dart';
import 'package:klik/screens/screens_widget/app_large_text.dart';
import 'package:klik/screens/screens_widget/backScreenWidget.dart';
import 'package:klik/screens/screens_widget/colors.dart';
import 'package:klik/screens/transaction_limit.dart';
import 'package:provider/provider.dart';

import 'KAChangePinScreen.dart';


class UserCard extends StatefulWidget {
  final String pageTag;
  const UserCard({Key? key, required this.pageTag}) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {

  @override
  Widget build(BuildContext context) {
    var cardItems = Provider.of<DashboardProvider>(context, listen: false);
    cardItems.dashboardProvider();
    return Scaffold(
      appBar: BackTopBar(),
      body: Consumer<DashboardProvider>(builder: (context, data, child){
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
        ): SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: AppLargeText(text: "Card List", size: 22, color: AppColor.appMainColor,)),
                25.height,
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, int index){
                      var cardNums = index + 1;
                      var shortened = cardItems.userDate!.profileDetails;
                      print("$cardNums, $index");
                      return InkWell(
                        onTap: (){
                          !isChangePin(widget.pageTag)?TransLimitPage(cardId: shortened.vcards[index].id).launch(context):
                          KAChangePinScreen(cardId: shortened.vcards[index].id).launch(context);
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.appMainColor.withOpacity(0.5)
                              ),
                              child: AppText(text: cardNums.toString(), color: Colors.white,),
                            ),
                            15.width,
                            AppText(text: shortened.vcards[index].cardNumber, size: 18,),
                            Expanded(child: Container()),
                            Card(
                              elevation: 2,
                              child: Container(
                                width: 100,
                                height: 40,
                                alignment: Alignment.center,
                                child: AppLargeText(text: "Edit", size: 20, color: AppColor.appMainColor,),
                              ),
                            ),
                            10.height,
                          ],
                        ),
                      );
                    },
                    itemCount: cardItems.userDate!.profileDetails.vcards.length,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  bool isChangePin(String widgetTxt){
    return (widgetTxt.toLowerCase().compareTo("changepin")==0);
  }
}
