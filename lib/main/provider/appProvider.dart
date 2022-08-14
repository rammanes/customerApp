import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:klik/main/models/WAModel.dart';
import 'package:klik/main/models/topUpModel.dart';
import 'package:klik/main/models/transactions.dart';
import 'package:klik/main/preferences/preferences_provider.dart';
import 'package:klik/main/repository/appRepository.dart';
import 'package:klik/screens/login/model/loginResonseModel.dart';
import 'package:http/http.dart' as http;
import '../../screens/login/model/new_login_response.dart';
import '../models/pinModel.dart';


// Dashboard Provider class

class DashboardProvider extends ChangeNotifier{
  bool isLoading = false;
  bool isBack = false;
  Data? userDate;
  http.Response? dashboardResponse;
  String? userToken;
  var prefs = PreferencesProvider();


  Future<void> dashboardProvider() async {
    isLoading = true;
    userToken = await prefs.getUserToken();
    //print(userToken);
    dashboardResponse = await(dashboardRepository(userToken!));
   // print(dashboardResponse!.statusCode);
    if(dashboardResponse!.statusCode == 200){
      isBack = true;
      userDate = await(Data.fromJson(json.decode(dashboardResponse!.body)));
    //  print(userDate!.profileDetails.name);
    }

    isLoading = false;
    notifyListeners();

  }
}


// Transaction Provider class

class TransactionProvider extends ChangeNotifier{
  bool isLoading = false;
  bool isBack = false;
  TransactionModel? trans;
  http.Response? transactionResponse;
  String? userToken;
  var prefs = PreferencesProvider();


  Future<void> transProvider() async {
    isLoading = true;
    userToken = await prefs.getUserToken();
    //print(userToken);
    transactionResponse = await(transactionRepository(userToken!));
   // print(transactionResponse!.statusCode);
    if(transactionResponse!.statusCode == 200){
      isBack = true;
      trans = transactionModelFromJson(transactionResponse!.body);
      //print(trans!.transactions.length);
    }

    isLoading = false;
    notifyListeners();

  }
}

// Pin API Provider

class PinProvider extends ChangeNotifier{
  bool isLoading = false;
  bool isBack = false;
  http.Response? response;
  String? userToken;
  var prefs = PreferencesProvider();
  List<Pin>? pinModel;

  Future<void> pinProvider(int pinNumber, int amount, String product) async {
    isLoading = true;
    notifyListeners();
    userToken = await prefs.getUserToken();
    response = await pinRespository(pinNumber, amount, product, userToken!);
    print(response!.statusCode);
    if(response!.statusCode == 200){
      isBack = true;
      pinModel = pinFromJson(response!.body);
      print(pinModel![0].pin);
    }

  }
}

class PaymentProvider extends ChangeNotifier{
  bool isBack = false;
  bool isLoading = false;
  http.Response? response;
  String? userToken;
  var prefs = PreferencesProvider();
  TopUpResponse? topUpResponse;

  Future<void> paymentProvider(TopUpBody data) async {
    userToken = await prefs.getUserToken();
    isLoading = true;
    notifyListeners();
    response = await paymentRepository(userToken!, data);
    print(response!.statusCode);
    if(response!.statusCode == 200){
      isBack = true;
      topUpResponse = topUpResponseFromJson(response!.body);
    }

    isLoading = false;
    notifyListeners();
  }

}


class CardLimitProvider extends ChangeNotifier{
  bool isBack = false;
  bool isLoading = false;
  http.Response? response;
  String? userToken;
  var prefs = PreferencesProvider();

  Future<void> cardLimitProvider(CardLimit cardLimit, int cardId) async {
    userToken = await prefs.getUserToken();
    isLoading = true;
    notifyListeners();
    response = await limitRepository(userToken!, cardLimit, cardId);
    print(response!.statusCode);
    if(response!.statusCode == 200){
      isBack = true;
    }
    isLoading = false;
    notifyListeners();
  }

}

// reference provider
class RefProvider extends ChangeNotifier{
  bool isBack = false;
  bool isLoading = false;
  http.Response? response;
  String? userToken;
  var prefs = PreferencesProvider();

  Future<void> refProvider(String refId) async {
    userToken = await prefs.getUserToken();
    isLoading = true;
    notifyListeners();
    response = await refRepository(userToken!, refId);
    print(response!.statusCode);
    if(response!.statusCode == 200){
      isBack = true;
    }
    isLoading = false;
    notifyListeners();
  }

}

class ChangePinProvider extends ChangeNotifier{
  bool isBack = false;
  bool isLoading = false;
  http.Response? response;
  String? userToken;
  var prefs = PreferencesProvider();

  Future<void> changePinProvider(int cardId, String pin) async {
    userToken = await prefs.getUserToken();
    isLoading = true;
    notifyListeners();
    response = await changePinRepository(userToken!, cardId, pin);
    print(response!.statusCode);
    if(response!.statusCode == 200){
      isBack = true;
    }
    isLoading = false;
    notifyListeners();
  }

}