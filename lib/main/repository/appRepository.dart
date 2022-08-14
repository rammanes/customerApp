import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:klik/main/models/topUpModel.dart';
import 'package:klik/main/utils/AppConstant.dart';

import '../models/WAModel.dart';

// Dashboard ApI repository
String baseUrl = testBaseUrl;
Future<http.Response> dashboardRepository(String token) async{
  http.Response? response;

  var dashboardUrl = "/api/customer/dashboard";
  try{
    response = await http.get(Uri.parse('$baseUrl$dashboardUrl'),
        headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json'
        }
    );
  }catch(e){
    print(e.toString());
  }
  return response!;
}

// Transactions API Repository

Future<http.Response> transactionRepository(String token) async{
  http.Response? response;

  var transactionUrl = "/api/customer/transactions";
  try{
    response = await http.get(Uri.parse('$baseUrl$transactionUrl'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json'
        }
    );
  }catch(e){
    print(e.toString());
  }
  return response!;
}

// Generate Voucher Code API Repository

Future<http.Response> pinRespository(int pinNumber, int amount, String product, String token) async {
  http.Response? response;
  Map body= {
    "number_of_pins": pinNumber,
    "amount": amount,
    "product": product
  };

  var pinUrl = "/api/customer/vouchers";
  try{
    response = await http.post(Uri.parse('$baseUrl$pinUrl'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      },
      body: json.encode(body)
    );
  }catch(e){
    print(e.toString());
  }
  return response!;
}

Future<http.Response> paymentRepository(String token, TopUpBody data) async{
  http.Response? response;
  String gateWayUrl = "https://sandbox.klik.ng/api/v1/request-checkout";
  print(topUpBodyToJson(data));
  try{
    response = await http.post(Uri.parse(gateWayUrl),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer 13|OaxLnFTfTwlaqcQbtSavKb3pum8oahMMOgoHunsD',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      },
      body: topUpBodyToJson(data),

    );
  }catch(e){
    print(e.toString());
  }
  return response!;
}

Future<http.Response> limitRepository(String token, CardLimit data, int cardId) async{
  http.Response? response;
  String limitUrl = "/api/customer/cards/$cardId/cardlimit";
  print(limitUrl);
  try{
    response = await http.patch(Uri.parse('$baseUrl$limitUrl'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      },
      body: cardLimitToJson(data),
    );
  }catch(e){
    print(e.toString());
  }
  return response!;
}

// Reference repository

Future<http.Response> refRepository(String token, String refId) async{
  http.Response? response;
  Map<String, String> body = {
    "reference_id": refId
  };
  String refUrl = "/api/customer/topup/initialize";
  try{
    response = await http.post(Uri.parse('$baseUrl$refUrl'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      },
      body: json.encode(body)
    );
  }catch(e){
    print(e.toString());
  }
  return response!;
}

// here is the repository that handles change pin

Future<http.Response> changePinRepository(String token, int cardId, String pin) async{
  http.Response? response;
  Map<String, String> body = {
    "pin": pin
  };
  String changePinUrl = "/api/customer/cards/$cardId/changepin";
  try{
    response = await http.patch(Uri.parse('$baseUrl$changePinUrl'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json'
        },
        body: json.encode(body)
    );
  }catch(e){
    print(e.toString());
  }
  return response!;
}