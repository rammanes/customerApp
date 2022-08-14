import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/extensions/WidgetExtension.dart';
import 'package:klik/main/models/WAModel.dart';
import 'package:klik/main/provider/WADataProvider.dart';
import 'package:klik/main/provider/appProvider.dart';
import 'package:klik/main/utils/AppColors.dart';
import 'package:klik/screens/KATopUpScreen.dart';
import 'package:klik/screens/KATransactionsScreen.dart';
import 'package:klik/screens/pin_module/generate_pin_page.dart';
import 'package:klik/screens/screens_widget/topBarWidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'KAGeneratePinScreen.dart';
import 'KAManageCardScreen.dart';
import 'screens_widget/appText.dart';
import 'screens_widget/app_large_text.dart';
import 'screens_widget/category_card.dart';
import 'screens_widget/colors.dart';
import 'screens_widget/trans_widget.dart';

class KAHomeScreen extends StatefulWidget {
  @override
  _KAHomeScreenState createState() => _KAHomeScreenState();
}

class _KAHomeScreenState extends State<KAHomeScreen> {
  List<Transactions> transactionList = [];
  String? userProfileType;
  bool isEvenDefault = false;
  late StreamSubscription internetSubscription;

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userProfileType = prefs.getString("profileType");
    });
  }
  Future _refresh() async{
    setState((){});
  }
  bool hasInternet = false;
  @override
  void initState() {
    internetSubscription = InternetConnectionChecker().onStatusChange.listen((event) {
      final hasInternet = event ==InternetConnectionStatus.connected;
      setState(()=> this.hasInternet= hasInternet);
    });
    transactionList = getTransactions();
    getUser();
    super.initState();
  }

  @override
  void dispose(){
    internetSubscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final dashboardData =
        Provider.of<DashboardProvider>(context, listen: false);
    dashboardData.dashboardProvider();
    // print(userProfileType);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        body:hasInternet? Consumer<DashboardProvider>(builder: (context, data, child) {
        return data.isLoading
            ? Center(
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
              )
        : ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset("assets/images/beard.png"),
                  ),
                  const SizedBox(width: 15,),
                  Text(data.userDate!.merchant.name, style: const TextStyle(
                    fontSize: 19
                  ),)
                ],
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: AppText(
                text:
                    "Welcome, ${dashboardData.userDate!.profileDetails.name}",
                color: AppColor.appMainColor,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.only(left: 50, top: 30),
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(15)),
                  color: AppColor.appBlue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppText(
                    text: "Available Balance",
                    color: AppColor.appWhite,
                    size: 18,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppLargeText(
                    text:
                        "NGN ${dashboardData.userDate!.profileDetails.balance.toString()}. 00",
                    color: AppColor.appWhite,
                    size: 22,
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            newCardSection(userProfileType!),
            //buildCardWidget(userProfileType!),
            25.height,
            recentTransWidget(),
            15.height,
            transactionListWidget(),
          ],
        );
      }): const AlertDialog(
          content: Text("No internet"),
        ),)
    );
  }

  Widget newCardSection(String profileType) => Container(
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 10),
      height: 120,
      width: double.infinity,
      child: Card(
        elevation: 3,
        color: Colors.purple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: profileType.isEmpty
            ? CircularProgressIndicator()
            : isOrganization(profileType)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          KAManageCardScreen().launch(context);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.credit_card,
                              color: appWhite,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Manage Card",
                              style: TextStyle(fontSize: 14, color: appWhite),
                            )
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        thickness: 1,
                        indent: 40.0,
                        endIndent: 40.0,
                        color: appWhite,
                      ),
                      GestureDetector(
                        onTap: () {
                          KATopUpScreen().launch(context);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add_to_home_screen,
                              color: appWhite,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Top Up",
                              style: TextStyle(
                                  fontSize: 14, color: appWhite),
                            )
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        thickness: 1,
                        indent: 40.0,
                        endIndent: 40.0,
                        color: appWhite,
                      ),
                      GestureDetector(
                        onTap: () {
                          KAGeneratePinScreen().launch(context);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.qr_code_sharp,
                              color: appWhite,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Generate Voucher",
                              style: TextStyle(fontSize: 14, color: appWhite),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          KAManageCardScreen().launch(context);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.credit_card,
                              color: appWhite,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Manage Card",
                              style: TextStyle(fontSize: 14, color: appWhite),
                            )
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        thickness: 1,
                        indent: 40.0,
                        endIndent: 40.0,
                        color: appWhite,
                      ),
                      GestureDetector(
                        onTap: () {
                          KATopUpScreen().launch(context);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add_to_home_screen,
                              color: appWhite,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Top Up",
                              style: TextStyle(fontSize: 14, color: appWhite),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
      ));

  Widget recentTransWidget() => Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppLargeText(
              text: "Recent Transactions",
              size: 18,
              color: AppColor.appMainColor,
            ),
            InkWell(
              onTap: (){
                KATransactionsScreen().launch(context);
              },
              child: AppText(
                text: "See all",
                color: Colors.purpleAccent,
              ),
            )
          ],
        ),
      );

  Widget transactionListWidget() {
    final transProv = Provider.of<TransactionProvider>(context, listen: false);
    transProv.transProvider();
    var formattedDate = DateFormat('EEEE, MMM d, yyyy  hh:mm:ss');
    return Consumer<TransactionProvider>(
      builder: (context, data, child) {
        return data.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(children: [
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        TransWidget(
                          fontColor: appTextColorSecondary,
                          date: formattedDate
                              .format(transProv.trans!.data[index].createdAt),
                          amount:
                              "NGN ${transProv.trans!.data[index].amount.toString()}",
                          color: Colors.green,
                          location: transProv.trans!.data[index].location,
                        ),
                      ],
                    ),
                  ),
                  itemCount: transProv.trans!.data.length,
                ),
              ]);
      },
    );
  }

  bool isCredit(String transStatus) => transStatus.toLowerCase() == 'credit';

  bool isSuccessful(String transStatus) =>
      transStatus.toLowerCase() == 'successful';

  bool isOrganization(String profileType) {
    return profileType.toLowerCase() == 'organization'; //ORGANIZATION
  }

  currency(context) {
    Locale locale = Localizations.localeOf(context);
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    return format;
  }
}
