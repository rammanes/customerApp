import 'package:flutter/material.dart';
import 'package:klik/screens/login/model/loginResonseModel.dart';
import 'package:klik/screens/login/respository/loginRepository.dart';
import 'package:http/http.dart' as http;
class LoginProvider extends ChangeNotifier{
  bool loading = false;
  bool isBack = false;
  LoginResponse? loginModel;
  http.Response? response;

  Future<void> loginProvider(String username, String password) async {
    loading = true;
    notifyListeners();
    response = (await loginRepository(username, password));
    print(response!.statusCode);
    if(response!.statusCode == 200){
      isBack = true;
      loginModel = loginResonseFromJson(response!.body);
    }

    loading = false;
    notifyListeners();
  }
}