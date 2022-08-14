import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klik/main/extensions/NumExtension.dart';
import 'package:klik/main/utils/AppColors.dart';
import 'package:klik/screens/login/KALoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_page.dart';



class KASplashScreen extends StatefulWidget {

  @override
  State<KASplashScreen> createState() => _KASplashScreenState();
}

class _KASplashScreenState extends State<KASplashScreen> {

  double screenWidth = 0.0 ;
  double screenHeight = 0.0;
  String str = "Wavu";
  Timer? timer;

  // create user fields
  String? userId;
  String? token;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  getScreenSize(){
    setState(() {
      screenWidth = MediaQuery.of(context).size.width;
      screenHeight = MediaQuery.of(context).size.height;
    });
  }

  @override
  void setState(fn){
    if(mounted) super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    getScreenSize();
    return Scaffold(
     backgroundColor: appLandingScreen,
     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           if(Platform.isIOS)
             const CupertinoActivityIndicator(
               radius: 60,
               color: appWhite,
             )
           else
             TweenAnimationBuilder(
                 tween: Tween(begin: 0.0, end: 1.0),
                 duration: const Duration(seconds: 4),
                 builder: (context, value, _) => const SizedBox(
                   width: 60,
                   height: 60,
                   child: CircularProgressIndicator(
                     backgroundColor: appWhite,
                     strokeWidth: 8,
                   ),
                 )
             ),
           30.height,
           RichText(
             text: const TextSpan(
               text: ' Wavu',
               style: TextStyle(
                 fontWeight: FontWeight.w700,
                 fontSize: 70,
                 color: appWhite,
                 letterSpacing: 1
               )
             )
           )
         ],
       ),
     ),
    );
  }

  void getUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userId");
    print("UserId: "+userId.toString());
    token = preferences.getString("token");
    print("token: "+token.toString());

    setState(() {
      checkUser();
    });
  }

  void checkUser() async {
    if(userId !=null && token !=null){
      timer = Timer(const Duration(milliseconds: 2200),(){
        Route route = MaterialPageRoute(builder: (context) => MainPage());
        Navigator.pushReplacement(context, route);
      });
    }else{
      timer = Timer(const Duration(milliseconds: 2200), () {
        setState(()  {
          print("user is null");
          // open login screen
          Route route = MaterialPageRoute(builder: (context) => KALoginScreen());
          Navigator.pushReplacement(context, route);

        });
      });
    }
  }
}
