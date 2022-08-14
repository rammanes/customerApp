import 'package:flutter/material.dart';
import 'package:klik/screens/login/respository/loginRepository.dart';
import 'package:http/http.dart' as http;

import '../model/new_login_response.dart';
class LoginProvider extends ChangeNotifier{
  bool loading = false;
  bool isBack = false;
  LoginResponseModel? loginModel;

  Future<void> loginProvider(String username, String password) async {
    loading = true;
    notifyListeners();
    http.Response response = (await loginRepository(username, password));
    print(response.statusCode);
    if(response.statusCode == 200){
      isBack = true;
      loginModel = loginResponseFromJson(response.body);
    }else if(response.statusCode == 422){
      isBack= false;
    }

    loading = false;
    notifyListeners();
  }
}

class ManagePassword extends ChangeNotifier {
  bool _showPassword = false;

  bool get showPassword => _showPassword;

  void makePasswordVisible() {
    _showPassword = !_showPassword;
    notifyListeners();
  }
}