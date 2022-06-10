import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/extensions/WidgetExtension.dart';
import 'package:klik/main/models/WAModel.dart';
import 'package:klik/main/provider/WADataProvider.dart';
import 'package:klik/main/provider/appProvider.dart';
import 'package:klik/main/utils/AppColors.dart';
import 'package:klik/main/utils/AppConstant.dart';
import 'package:klik/main/utils/AppUtils.dart';
import 'package:klik/screens/KAPayOptions.dart';
import 'package:klik/screens/KATopUpScreen.dart';
import 'package:klik/screens/KATransactionsScreen.dart';
import 'package:klik/screens/screens_widget/summaryWidget.dart';
import 'package:klik/screens/screens_widget/topBarWidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'KAGeneratePinScreen.dart';
import 'login/model/loginResonseModel.dart';



class KAHomeScreen extends StatefulWidget {

  @override
  _KAHomeScreenState createState() => _KAHomeScreenState();
}

class _KAHomeScreenState extends State<KAHomeScreen> {
  List<Transactions> transactionList = [];
  String? userToken;
  SharedPreferences? preferences;

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    String? userToken = preferences!.getString("token");
    if (userToken == null) return;
    setState(() => this.userToken = userToken);
  }

  @override
  void initState() {
    super.initState();
    init();
    transactionList = getTransactions();
    final dashboardData = Provider.of<DashboardProvider>(context, listen: false);
    dashboardData.dashboardProvider();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardData = Provider.of<DashboardProvider>(context);
    dashboardData.dashboardProvider();
    return Scaffold(
        appBar: TopBarWidget(),

        body: dashboardData.userData!.profileDetails.name.isEmpty? CircularProgressIndicator():
        Center(
            child: Text(dashboardData.userData!.profileDetails.name, style: TextStyle(color: appLandingScreen, fontSize: 32 ),))
    );
  }

  Widget buildSummaryWidget(String name) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '$welcomeText $name !',
                style: const TextStyle(fontSize: 14, color: deepBlue),
              ),
            ),
            20.height,
            buildBalanceWidget(context),
          ],
        ),
      );

  Widget buildBalanceWidget(BuildContext context) => Container(
        height: Utility(context).height * 0.065,
        child: Stack(
          children: [
            const Positioned(
              top: 20,
              child: Text(
                balanceText,
                style: TextStyle(fontSize: 14, color: appTextColorSecondary),
              ),
            ),
            const Positioned(
              top: 10,
              left: 80,
              child: Text(
                "NGN",
                style: TextStyle(
                    fontSize: 24, color: deepBlue, fontWeight: FontWeight.w500),
              ),
            ),
            Positioned(
              top: 12,
              left: 140,
              child: RichText(
                text: const TextSpan(
                    text: "2,000",
                    style: TextStyle(
                        fontSize: 36,
                        color: deepBlue,
                        fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                        text: ".00",
                        style: TextStyle(
                            fontSize: 30,
                            color: deepBlue,
                            fontWeight: FontWeight.w500),
                      )
                    ]),
              ),
            ),
          ],
        ),
      );

  Widget buildCardWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                KAPayOptions().launch(context);
              },
              child: Container(
                child: Image.asset(
                  'assets/images/icons/manageKd.png',
                  height: 130,
                  width: 150,
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                KATopUpScreen().launch(context);
              },
              child: Container(
                child: Image.asset(
                  'assets/images/icons/topUp.png',
                  height: 130,
                  width: 150,
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                KAGeneratePinScreen().launch(context);
              },
              child: Container(
                child: Image.asset(
                  'assets/images/icons/generatePin.png',
                  height: 130,
                  width: 150,
                ),
              ),
            ),
          ),
        ],
      );

  Widget recentTransWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(recentTransaction,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: deepBlue)),
                GestureDetector(
                  onTap: () {
                    KATransactionsScreen().launch(context);
                  },
                  child: const Text(seeAll,
                      style: TextStyle(
                          fontSize: 16, color: appTextColorSecondary)),
                ),
              ],
            ),
            20.height,
          ],
        ),
      );

  Widget transactionListWidget() => Container(
        child: SingleChildScrollView(
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      isCredit(
                                              '${transactionList[index].transType!}')
                                          ? Icon(
                                              Icons.add,
                                              size: 10,
                                              color: appGreenColor,
                                            )
                                          : Icon(
                                              Icons.remove,
                                              size: 10,
                                              color: appRedColor,
                                            ),
                                      Text(
                                        'NGN ${transactionList[index].amount!}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: isCredit(
                                                    '${transactionList[index].transType!}')
                                                ? appGreenColor
                                                : appRedColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 35),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          transactionList[index].date!,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        transactionList[index].status!,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: isSuccessful(
                                                    '${transactionList[index].status!}')
                                                ? appGreenColor
                                                : appRedColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            8.height,
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 15,
                                ),
                                8.width,
                                Text(
                                  transactionList[index].location!,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => const Divider(
                      color: Colors.transparent,
                    ),
                itemCount: transactionList.length)),
      );

  bool isCredit(String transStatus) => transStatus.toLowerCase() == 'credit';

  bool isSuccessful(String transStatus) =>
      transStatus.toLowerCase() == 'successful';
}
