import 'package:flutter/material.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/screens/screens_widget/generalTopBar.dart';

import '../main/utils/AppColors.dart';
import '../main/utils/AppWidget.dart';

class KAChangePinScreen extends StatefulWidget {
  const KAChangePinScreen({Key? key}) : super(key: key);

  @override
  State<KAChangePinScreen> createState() => _KAChangePinScreenState();
}

class _KAChangePinScreenState extends State<KAChangePinScreen> {

  TextEditingController _currentPin = TextEditingController();
  TextEditingController _newPin = TextEditingController();
  TextEditingController _confirmPin = TextEditingController();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralTopBar(),
      body: ListView(
        children: [
          Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(45, 15, 45, 10),
              child: Column(
                children: [
                  buildChangePinWidget(),
                  15.height,
                  buildReusableTextField(_currentPin, "current pin", "Enter current pin"),
                  buildReusableTextField(_newPin, "new pin", "Enter new pin"),
                  buildReusableTextField(_confirmPin, "confirm pin", "Confirm new pin"),
                  30.height,
                  buildChangePinButton(),
                ],
              )),
        ],
      ),
    );
  }
  Widget buildChangePinWidget() => const Text("Change Pin", textAlign: TextAlign.center, style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: appLandingScreen
  ),);

  Widget buildReusableTextField(TextEditingController controller, String hintText, String topText) =>  Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.only(top: 25),
        child: Text(topText, style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: appLandingScreen
        ),),
      ),
      Container(
          padding: EdgeInsets.fromLTRB(0,16,0, MediaQuery.of(context).viewInsets.bottom),
          child: shadowPasswordField(controller, hintText, _showPassword, (){
            setState((){
              _showPassword = !_showPassword;
            });
          })
      ),
    ],
  );

  Widget  buildChangePinButton() =>  Container(
    alignment: Alignment.bottomCenter,
    padding: const EdgeInsets.only(top: 45),
    child: raisedButton(() => null, 'Change Pin', double.infinity, 50),
  );
}
