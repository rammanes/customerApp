import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> loginRepository(String email, String password) async {
  http.Response? response;
  var url = "https://wavu-endpoint.herokuapp.com/api/sanctum/token";
  Map body = {
    "username": email,
    "password": password
  };
  Map <String,String> headers = {'content-type':'application/json'};
  try{
    response = await http.post(Uri.parse(url), headers: headers, body: json.encode(body));
  }catch(e){
    print(e.toString());
  }

  return response!;
}