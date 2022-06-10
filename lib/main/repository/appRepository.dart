import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// Dashboard ApI repository
Future<http.Response> dashboardRepository(String token) async{
  http.Response? response;

  var dashboardUrl = "https://wavu-endpoint.herokuapp.com/api/customer/dashboard";
  try{
    response = await http.get(Uri.parse(dashboardUrl),
        headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
        }
    );
  }catch(e){
    print(e.toString());
  }
  return response!;
}