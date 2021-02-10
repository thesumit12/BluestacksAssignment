import 'package:bluestacks_assignment/navigation/app_navigator_factory.dart';
import 'package:bluestacks_assignment/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen(this.factory);

  final AppNavigatorFactory factory;

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      checkLoginStatus(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    String userId = await getUserId();
    if (userId != null) {
      widget.factory.get(context).navigateToHomePage(userId);
    }
    else {
      widget.factory.get(context).navigateToLoginPage();
    }
  }

  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isLoggedIn = preferences.getBool(IS_LOGGED_IN) ?? false;
    String userId = preferences.getString(USER_ID);
    if (isLoggedIn) {
      return userId;
    }
    return null;
  }
}
