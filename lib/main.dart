import 'package:flutter/material.dart';
import 'package:klik/main/provider/appProvider.dart';
import 'package:klik/main/utils/AppColors.dart';
import 'package:klik/screens/KASplashScreen.dart';
import 'package:klik/screens/login/provider/loginProvider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(KlikApp());
}

class KlikApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider.value(value: ManagePassword()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => PinProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => CardLimitProvider()),
        ChangeNotifierProvider(create: (_) => RefProvider()),
        ChangeNotifierProvider(create: (_) => ChangePinProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: appWhite, fontFamily: 'SplineSans'),
        home: KASplashScreen(),
      ),
    );
  }
}
