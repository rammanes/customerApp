import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/extensions/WidgetExtension.dart';
import 'package:klik/main/models/pinModel.dart';
import 'package:klik/main/provider/appProvider.dart';
import 'package:klik/screens/screens_widget/backScreenWidget.dart';
import 'package:klik/screens/screens_widget/generalTopBar.dart';
import 'package:provider/provider.dart';

import '../main/utils/AppColors.dart';
import '../main/utils/AppWidget.dart';
import 'KAPinGeneratedScreen.dart';

class KAGeneratePinScreen extends StatefulWidget {
  const KAGeneratePinScreen({Key? key}) : super(key: key);

  @override
  State<KAGeneratePinScreen> createState() => _KAGeneratePinScreenState();
}

class _KAGeneratePinScreenState extends State<KAGeneratePinScreen> {

  TextEditingController _amntPerPin = TextEditingController();
  TextEditingController _noOfPin = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _showPassword = false;
  List<String> categories = [
    'PMS',
    'AGO',
    'DPK',
    'LPG'
  ];
  String selectedCategories = "PMS";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackTopBar(),
      body: Consumer<PinProvider>(builder: (context, data, child){
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
        ):Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: buildGeneratePinWidget()
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
              height: 300,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: const Text("Product Type", textAlign: TextAlign.left, style: TextStyle(
                      color: appLandingScreen,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),),
                  ),
                  15.height,
                  buildDropDownSection(),
                  25.height,
                  buildPinDecisionWidget(),
                ],
              ),
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: buildGeneratePinButton(),
          )
        ],
      );}),
    );
  }
  Widget buildGeneratePinWidget() => const Text("Generate Pin", textAlign: TextAlign.center, style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: appLandingScreen
  ),);
  //
  // Widget buildReusableTextField(TextEditingController controller, String hintText, String topText) =>  Column(
  //   mainAxisAlignment: MainAxisAlignment.start,
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     Container(
  //       padding: const EdgeInsets.only(top: 25),
  //       child: Text(topText, style: const TextStyle(
  //           fontWeight: FontWeight.w500,
  //           color: appLandingScreen
  //       ),),
  //     ),
  //     Container(
  //         padding: EdgeInsets.fromLTRB(0,16,0, MediaQuery.of(context).viewInsets.bottom),
  //         child: shadowPasswordField(controller, hintText, _showPassword, (){
  //           setState((){
  //             _showPassword = !_showPassword;
  //           });
  //         })
  //     ),
  //   ],
  // );

  Widget  buildGeneratePinButton() =>  Container(
    alignment: Alignment.bottomCenter,
    padding: const EdgeInsets.only(top: 45, bottom: 45),
    child: raisedButton(() => onClickGeneratePin(), 'Generate', 200, 50),
  );

  Widget buildDropDownSection() => Container(
    height: 50,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 5), // changes position of shadow
        ),
      ],
    ),
    child: DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            borderSide: BorderSide(color: Colors.white, width: 1)

        ),
        contentPadding: EdgeInsets.only( left: 32.0, right: 10.0),
      ),
      hint: Text("Select Category"),
      value: selectedCategories,
      items: categories.map((category)=> DropdownMenuItem<String>(
          value: category,
          child: Text(category, style: const TextStyle(fontSize: 18),)
      )).toList(),
      onChanged: (category)=> setState(()=> selectedCategories = category!), ),
  );

  Widget buildPinDecisionWidget() => Flexible(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 25),
                child: const Text('Amnt Per Pin', textAlign: TextAlign.left, style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: appLandingScreen
                ),),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: shadowTextField( _amntPerPin, '5'),
              ),
            ],
          ),
        ),
        25.width,
        Expanded(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 25),
                child: const Text('No of Pin', textAlign: TextAlign.left, style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: appLandingScreen
                ),),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: shadowTextField( _noOfPin, '5'),
              ),
            ],
          ),
        )
      ],
    ),
  );

  onClickGeneratePin(){
    checkInputs();
  }
  void checkInputs(){
    String amount = _amntPerPin.text.toString();
    String pinNumber = _noOfPin.text.toString();
    if(amount.isEmpty){
      alertDialog("Please enter a valid amount");
    }else if(pinNumber.isEmpty){
      alertDialog("Please the number of pins");
    }else{
      generatePin();
    }
  }
  alertDialog(String message){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            // title: Text("Pin"),
            content: Text(message),
          );
        }
    ); //end showDialog()
  }

  void generatePin() async {
    int amount = int.parse( _amntPerPin.text.toString());
    int pinNumber = int.parse( _noOfPin.text.toString());
    List<Pin> pinList;
    String product = selectedCategories;
    var pinProv = Provider.of<PinProvider>(context, listen: false);
    await pinProv.pinProvider(pinNumber, amount, product);
    if(pinProv.isBack){
      pinList = pinProv.pinModel!;
      KAPinGeneratedScreen(getPinList : pinList).launch(context);
    }else {
      alertDialog("Failed to generate pin");
    }
  }
}
