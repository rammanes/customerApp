import 'package:flutter/material.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/extensions/WidgetExtension.dart';
import 'package:klik/screens/login/KALoginScreen.dart';
import 'package:klik/screens/screens_widget/generalTopBar.dart';
import 'package:klik/screens/screens_widget/menuTopBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main/utils/AppColors.dart';
import 'KAManageCardScreen.dart';
import 'KAPayOptions.dart';


class KASettingsScreen extends StatefulWidget {
  const KASettingsScreen({Key? key}) : super(key: key);

  @override
  _KASettingsScreenState createState() => _KASettingsScreenState();
}

class _KASettingsScreenState extends State<KASettingsScreen> {

  SharedPreferences? preferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuTopBar(),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 10),
        child: Column(
          children: [
            buildSettingsWidget(),
            15.height,
            InkWell(
              onTap: (){KAManageCardScreen().launch(context);},
              child: buildSettingsItems('assets/images/icons/manageCard.png')),
            InkWell(
              onTap: (){KAPayOptions().launch(context);},
              child: buildSettingsItems('assets/images/icons/mgdPaySettings.png')),
            buildSettingsItems('assets/images/icons/apperanceSettings.png'),
            InkWell(
              onTap: () async {
                preferences= await SharedPreferences.getInstance();
                preferences!.remove("userId");
                preferences!.remove("token");
                preferences!.remove("profileType");
                Route route = MaterialPageRoute(builder: (context) => KALoginScreen());
                Navigator.pushReplacement(context, route);
              },
              child: buildSettingsItems('assets/images/icons/logout.png')),
          ],
        ),
      ),
    );
  }

  Widget buildSettingsWidget() => const Text("Settings", textAlign: TextAlign.center, style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: appLandingScreen
  ),);

  Widget buildSettingsItems(String imageUrl) => Container(
    height: 70,
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
    child: Image.asset(imageUrl, fit: BoxFit.cover,),
  );
}
