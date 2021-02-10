
import 'package:bluestacks_assignment/navigation/app_navigator.dart';
import 'package:flutter/material.dart';

class AppNavigatorFactory {
  AppNavigator get(BuildContext context) =>
      AppNavigator.forNavigator(Navigator.of(context));
}