import 'package:bluestacks_assignment/util/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoggedIn = false;
  bool isLoginButtonEnabled = false;
  String userName = '';
  String password = '';

  static const users = const {
    '9898989898': 'password',
    '9876543210': 'password',
  };

  Future<bool> setLoginStatus(bool status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(USER_ID, userName);
    return await preferences.setBool(IS_LOGGED_IN, status);
  }

  String login() {
    if(!users.containsKey(userName)) {
      return 'username_error'.tr();
    }
    if(users[userName] != password) {
      return 'password_error'.tr();
    }
    return null;
  }

  changeLoginButtonState(String name, String pwd) {
    userName = name;
    password = pwd;
    bool currentValue = userName.length >= 3 && password.length >= 3;
    if(currentValue != isLoginButtonEnabled) {
      isLoginButtonEnabled = currentValue;
      notifyListeners();
    }
  }
}
