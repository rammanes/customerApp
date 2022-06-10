import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:klik/main/preferences/preferences_provider.dart';
import 'package:klik/main/repository/appRepository.dart';
import 'package:klik/screens/login/model/loginResonseModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashboardProvider extends ChangeNotifier{
  bool isLoading = false;
  bool isBack = false;
  Data? userData;
  http.Response? dashboardResponse;
  String? userToken;
  var prefs = PreferencesProvider();


  Future<Data> dashboardProvider() async {
    isLoading = true;
    userToken = await prefs.getUserToken();
    print(userToken);
    dashboardResponse = await(dashboardRepository(userToken!));
    if(dashboardResponse!.statusCode == 200){
      isBack = true;
      userData = await(Data.fromJson(json.decode(dashboardResponse!.body)));
      print(userData!.profileDetails.name);
      return userData!;
    }
   throw Exception();
  }
}