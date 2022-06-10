import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:klik/main/extensions/WidgetExtension.dart';
import 'package:klik/main/utils/AppColors.dart';
import 'package:klik/main/utils/AppWidget.dart';
import 'package:klik/screens/KADashboardScreen.dart';
import 'package:klik/screens/login/model/loginResonseModel.dart';
import 'package:klik/screens/login/provider/loginProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KALoginScreen extends StatefulWidget {
  @override
  State<KALoginScreen> createState() => _KALoginScreenState();
}

class _KALoginScreenState extends State<KALoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController=  TextEditingController();
  double screenWidth = 0.0 ;
  double screenHeight = 0.0;
  bool _showPassword = false;

  getScreenSize(){
    setState(() {
      screenWidth = MediaQuery.of(context).size.width;
      screenHeight = MediaQuery.of(context).size.height;
    });
  }
  @override
  Widget build(BuildContext context) {
    getScreenSize();
    return Scaffold(
     body: Container(
          padding: const EdgeInsets.all(35),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 60, bottom: 20),
                alignment: Alignment.center,
                child: const Text(
                  "Sign in", style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: appLandingScreen
                ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.fromLTRB(64, 10, 64, 0),
                child: Image.asset('assets/images/loginImage.png'),
              ),
              Container(
                padding: const EdgeInsets.only(top: 40),
                child: const Text('Username', style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: appLandingScreen
                ),),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: shadowTextField(_usernameController, 'maasum@example.com'),
              ),
              Container(
                padding: const EdgeInsets.only(top: 25),
                child: const Text('Password', style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: appLandingScreen
                ),),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, MediaQuery
                      .of(context)
                      .viewInsets
                      .bottom),
                  child: shadowPasswordField(
                      _passwordController, 'password', _showPassword, () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  })
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(top: 45),
                child: raisedButton(() => onClickLogin(), 'Login', screenWidth,
                    50),
              )

            ],
          ),
        )
     );
  }

  void onClickLogin() {
    checkInputs();
    print("login");
  }

  void checkInputs(){
    String email = _usernameController.text.toString();
    String password = _passwordController.text.toString();
    if(email.isEmpty){
      alertDialog("Please enter your email");
    }else if(password.isEmpty){
      alertDialog("Please enter the password");
    }else{
      login();
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
  void login() async{
    String email = _usernameController.text.toString();
    String password = _passwordController.text.toString();
    var loginResponse = Provider.of<LoginProvider>(context, listen: false);
    await loginResponse.loginProvider(email, password);
    if(loginResponse.isBack){
      String token = loginResponse.loginModel!.token;
      String userId = loginResponse.loginModel!.data.profileDetails.userId.toString();
      saveUser(userId, token);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => KADashboardScreen()));
    }else {
      print("failed");
      alertDialog("Login failed");

    }
  }
  saveUser(String userId,  String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", userId);
    prefs.setString("token", token);
  }


}
