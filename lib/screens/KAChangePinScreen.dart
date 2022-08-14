import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/provider/appProvider.dart';
import 'package:klik/screens/screens_widget/generalTopBar.dart';
import 'package:provider/provider.dart';

import '../main/utils/AppColors.dart';
import '../main/utils/AppWidget.dart';
import 'main_page.dart';

class KAChangePinScreen extends StatefulWidget {
  final int cardId;
  const KAChangePinScreen({Key? key, required this.cardId}) : super(key: key);

  @override
  State<KAChangePinScreen> createState() => _KAChangePinScreenState();
}

class _KAChangePinScreenState extends State<KAChangePinScreen> {

  TextEditingController _currentPin = TextEditingController();
  TextEditingController _newPin = TextEditingController();
  TextEditingController _confirmPin = TextEditingController();
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralTopBar(),
      body: Consumer<ChangePinProvider>(builder: (context, data, child) {
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
        ) : SingleChildScrollView(
           child: Column(
             children:[
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
            ]
      ));})
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
          //padding: EdgeInsets.fromLTRB(0,16,0, MediaQuery.of(context).viewInsets.bottom),
          child: shadowPasswordField(controller, hintText, _showPassword, (){})
      ),
    ],
  );

  Widget  buildChangePinButton() =>  Container(
    alignment: Alignment.bottomCenter,
    padding: const EdgeInsets.only(top: 45),
    child: raisedButton(() => changePin(), 'Change Pin', double.infinity, 50),
  );

  changePin(){
    checkInput();
  }
  checkInput(){
    String currentPin = _currentPin.text.toString();
    String newPin = _newPin.text.toString();
    String confirmPin = _confirmPin.text.toString();
    if(currentPin.isEmpty){
      alertDialog("Please enter current pin");
    }else if(newPin.isEmpty){
      alertDialog("Please enter new pin");
    }else if(confirmPin.isEmpty){
      alertDialog("Please confirm new pin");
    } else if(newPin!=confirmPin){
      alertDialog("Pin mismatch");
    }else{
      implementChange();
    }
  }

  void implementChange() async{
    var pinProvider = Provider.of<ChangePinProvider>(context, listen: false);
    var newPin = _newPin.text.toString();
    await pinProvider.changePinProvider(widget.cardId, newPin);
    if(pinProvider.isBack){
      alertDialog("Pin Changed Successfully");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> MainPage()), (route) => false);
    }else{
      alertDialog("An error has occured");
    }

  }
  alertDialog(String message){
    showDialog(
        context: context,
        builder: (context)=> AlertDialog(content: Text(message),));
  }
}

