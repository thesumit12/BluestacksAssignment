
import 'package:bluestacks_assignment/navigation/app_navigator.dart';
import 'package:bluestacks_assignment/navigation/app_navigator_factory.dart';
import 'package:flutter/material.dart';


class TestAppNavigationFactory extends AppNavigatorFactory {
  TestAppNavigationFactory(this.mockAppNavigator);
  final AppNavigator mockAppNavigator;

  @override
  AppNavigator get(BuildContext context) => mockAppNavigator;
}