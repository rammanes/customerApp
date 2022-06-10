import 'package:flutter/material.dart';
import 'package:klik/main/utils/AppColors.dart';
import 'package:klik/main/utils/AppConstant.dart';
import 'package:klik/main/utils/AppWidget.dart';
import 'package:klik/screens/screens_widget/topBarWidget.dart';

import 'KAHomeScreen.dart';
import 'KAManageCardScreen.dart';
import 'KASettingsScreen.dart';
import 'KATransactionsScreen.dart';

class KADashboardScreen extends StatefulWidget {
  @override
  _KADashboardScreenState createState() => _KADashboardScreenState();
}

class _KADashboardScreenState extends State<KADashboardScreen> {
  int _selectedIndex = 0;

  var _pages = <Widget> [
    KAHomeScreen(),
    KATransactionsScreen(),
    KASettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: bottomNavigationBar(),
        body: Center(child: _pages.elementAt(_selectedIndex),)
      ),
    );
  }

  Widget bottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: appWhite,
          boxShadow: [
            BoxShadow(
              color: appGreyColor.withOpacity(0.2),
              blurRadius: 6,
              spreadRadius: 6,
            )
          ]
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: appTextColorSecondary
              )
            )
          ),
          child: NavigationBar(
            height: 60,
            backgroundColor: Colors.transparent,
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            animationDuration: Duration(seconds: 3),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: home),
              NavigationDestination(icon: Icon(Icons.monetization_on_outlined), label: transText),
              NavigationDestination(icon: Icon(Icons.settings), label: settings)
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
