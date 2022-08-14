import 'package:flutter/material.dart';
import 'package:klik/main/utils/AppColors.dart';


class VoucherPinPage extends StatefulWidget {
  const VoucherPinPage({Key? key}) : super(key: key);

  @override
  State<VoucherPinPage> createState() => _VoucherPinPageState();
}

class _VoucherPinPageState extends State<VoucherPinPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appWhite,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_outlined, size: 20, color: appUIDarker,),
      ),
        title: const SizedBox(
          height: 35.0,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Generate Pin",
              style: TextStyle(
                  color: appLandingScreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
        ),
    ));
  }
}
