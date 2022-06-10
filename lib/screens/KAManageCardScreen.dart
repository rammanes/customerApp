import 'package:flutter/material.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/extensions/WidgetExtension.dart';
import 'package:klik/screens/KAChangePinScreen.dart';
import 'package:klik/screens/screens_widget/generalTopBar.dart';

import '../main/utils/AppColors.dart';

class KAManageCardScreen extends StatefulWidget {
  const KAManageCardScreen({Key? key}) : super(key: key);

  @override
  _KAManageCardScreenState createState() => _KAManageCardScreenState();
}

class _KAManageCardScreenState extends State<KAManageCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralTopBar(),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 10),
        child: Column(
          children: [
            buildManageCardWidget(),
            15.height,
            InkWell(
              onTap: (){KAChangePinScreen().launch(context);},
              child: buildSettingsItems('assets/images/icons/changePin.png')),
            buildSettingsItems('assets/images/icons/setLimit.png'),
          ],
        ),
      ),
    );
  }

  Widget  buildManageCardWidget() => const Text("Manage Card", textAlign: TextAlign.center, style: TextStyle(
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
