
import 'package:bluestacks_assignment/util/constants.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator.forNavigator(this._navigatorState);
  final NavigatorState _navigatorState;

  void navigateToLoginPage() {
    _navigatorState.pushReplacementNamed(LOGIN_PAGE);
  }

  void navigateToHomePage(String userId) {
    _navigatorState.pushReplacementNamed(HOME_PAGE, arguments: userId);
  }
}