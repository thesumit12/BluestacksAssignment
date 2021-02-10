
import 'package:bluestacks_assignment/home/home_page.dart';
import 'package:bluestacks_assignment/login/login_page.dart';
import 'package:bluestacks_assignment/navigation/app_navigator_factory.dart';
import 'package:bluestacks_assignment/util/constants.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routeNames = <String, WidgetBuilder>{
  LOGIN_PAGE: (BuildContext context) => _getLoginPage(),
  HOME_PAGE: (BuildContext context) => _getHomePage(context)
};

AppNavigatorFactory navigatorFactory = AppNavigatorFactory();

Widget _getLoginPage() {
  return LoginPage(navigatorFactory);
}

Widget _getHomePage(BuildContext context) {
  final String userId = ModalRoute.of(context).settings.arguments;
  return HomePage(userId, navigatorFactory);
}