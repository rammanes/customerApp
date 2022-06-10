

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider{
  String USERID = 'userId';
  String USERTOKEN = 'token';

  Future<String> getUserToken() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(USERTOKEN)?? '';
  }


}