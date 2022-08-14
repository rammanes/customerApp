import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../main/utils/AppConstant.dart';
String baseUrl = testBaseUrl;
Future<http.Response> loginRepository(String email, String password) async {
  http.Response? response;
  var url = "/api/sanctum/token";
  Map body = {
    "username": email,
    "password": password
  };
  Map <String,String> headers = {'content-type':'application/json'};
  try{
    response = await http.post(Uri.parse('$baseUrl$url'), headers: headers, body: json.encode(body));
  }catch(e){
    print(e.toString());
  }

  return response!;
}

