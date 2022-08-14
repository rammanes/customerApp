import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/models/WAModel.dart';
import 'package:klik/main/utils/AppColors.dart';
import 'package:klik/screens/screens_widget/bottomNavigation.dart';
import 'package:klik/screens/screens_widget/generalTopBar.dart';
import 'package:klik/screens/screens_widget/trans_widget.dart';
import 'package:provider/provider.dart';

import '../main/provider/WADataProvider.dart';
import '../main/provider/appProvider.dart';
import 'screens_widget/menuTopBar.dart';


class KATransactionsScreen extends StatefulWidget {

  @override
  State<KATransactionsScreen> createState() => _KATransactionsScreenState();
}

class _KATransactionsScreenState extends State<KATransactionsScreen> {
  List<Transactions> transactionList = [];

  @override
  void initState() {
    super.initState();
    transactionList = getTransactions();
  }
  @override
  Widget build(BuildContext context) {
    final transProv = Provider.of<TransactionProvider>(context, listen: false);
    transProv.transProvider();
    var formattedDate = DateFormat('EEEE, MMM d, yyyy  hh:mm:ss');
    return SafeArea(
      child: Scaffold(
        appBar:MenuTopBar(),
        backgroundColor: appWhite,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTransactionWidget(),
              20.height,
              // ListView.separated(
              //     shrinkWrap: true,
              //     itemBuilder: (BuildContext context, int index) =>
              //         GestureDetector(
              //           onTap: () {},
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 25),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                   children: [
              //                     Container(
              //                       child: Row(
              //                         children: [
              //                           isCredit('${transactionList[index].transType!}')? Icon(Icons.add, size: 10, color: appGreenColor,) : Icon(Icons.remove, size: 10, color: appRedColor,),
              //                           Text(
              //                             'NGN ${transactionList[index].amount!}',
              //                             style: TextStyle(fontSize: 14,
              //                                 color: isCredit('${transactionList[index].transType!}')? appGreenColor : appRedColor),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                     Expanded(
              //                       child: Container(
              //                         padding: EdgeInsets.only(left: 35),
              //                         child: Column(
              //                           crossAxisAlignment: CrossAxisAlignment.start,
              //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                           children: [
              //                             Text(
              //                               transactionList[index].date!,
              //                               style: const TextStyle(fontSize: 14),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                     Container(
              //                       alignment: Alignment.centerLeft,
              //                       child: Column(
              //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                         children: [
              //                           Text(
              //                             transactionList[index].status!,
              //                             textAlign: TextAlign.left,
              //                             style: TextStyle(fontSize: 14, color: isSuccessful('${transactionList[index].status!}') ? appGreenColor : appRedColor),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 8.height,
              //                 Row(
              //                   children: [
              //                     const Icon(
              //                       Icons.location_on,
              //                       size: 15,
              //                     ),
              //                     8.width,
              //                     Text(
              //                       transactionList[index].location!,
              //                       style: const TextStyle(fontSize: 10),
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //     separatorBuilder: (context, index) => const Divider(
              //       color: Colors.transparent,
              //     ),
              //     itemCount: transactionList.length),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      const SizedBox(height: 8,),
                      TransWidget(
                        fontColor: appTextColorSecondary,
                        date: formattedDate.format(
                            transProv.trans!.data[index].createdAt),
                        amount:
                        "NGN ${transProv.trans!.data[index].amount.toString()}",
                        color: Colors.green,
                        location:
                        transProv.trans!.data[index].location,
                      ),
                    ],
                  ),
                ),
                itemCount: transProv.trans!.data.length,
              ),
            ],
          )
        ),
      )
    );
  }

  bool isCredit(String transStatus) => transStatus.toLowerCase() == 'credit';
  bool isSuccessful(String transStatus) => transStatus.toLowerCase() == 'successful';

  Widget buildTransactionWidget(){
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            const Text("Transactions", style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: appLandingScreen
            ),),
            40.height,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children:  [
            //     Container(
            //         height: 30,
            //         width: 30,
            //         decoration: const BoxDecoration(
            //           color: UISky,
            //           shape: BoxShape.circle
            //         ),
            //         child: IconButton(onPressed: (){}, icon: Image.asset('assets/images/icons/bkIcon.png', height: 10, width: 15,))),
            //     10.width,
            //     // const Text("April", style: TextStyle(
            //     //   fontSize: 20,
            //     //   color: appLandingScreen,
            //     //   fontWeight: FontWeight.w600
            //     // ),),
            //     // 10.width,
            //     // Container(
            //     //     height: 30,
            //     //     width: 30,
            //     //     decoration: const BoxDecoration(
            //     //         color: UISky,
            //     //         shape: BoxShape.circle
            //     //     ),
            //     //     child: IconButton(onPressed: (){}, icon: Image.asset('assets/images/icons/frtIcon.png',  height: 10, width: 15,))),
            //   ],
            // )

          ],
        ),
      ),
    );
  }
}

