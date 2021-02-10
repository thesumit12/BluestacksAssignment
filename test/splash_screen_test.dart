import 'package:bluestacks_assignment/navigation/app_navigator.dart';
import 'package:bluestacks_assignment/splash_screen.dart';
import 'package:bluestacks_assignment/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'create_widget_for_testing.dart';
import 'navigation_factory_test.dart';

class MockAppNavigator extends Mock implements AppNavigator {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final MockAppNavigator appNavigator = MockAppNavigator();
  final TestAppNavigationFactory navigationFactory =
      TestAppNavigationFactory(appNavigator);

  setUp(() {
    reset(appNavigator);
  });

  testWidgets('Initial load test', (WidgetTester tester) async {
    await pumpWidget(tester: tester, widget: SplashScreen(navigationFactory));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('User not logged in navigate to Login Page',
      (WidgetTester tester) async {
    await setUpPreference(false);

    await pumpWidget(tester: tester, widget: SplashScreen(navigationFactory));
    expect(find.byType(Image), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    verify(appNavigator.navigateToLoginPage());
  });

  testWidgets('User logged in navigate to Home Page',
      (WidgetTester tester) async {
    await setUpPreference(true);

    await pumpWidget(tester: tester, widget: SplashScreen(navigationFactory));
    expect(find.byType(Image), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));

    verify(appNavigator.navigateToHomePage('9876543210'));
  });
}

Future<void> setUpPreference(bool value) async {
  SharedPreferences.setMockInitialValues(<String, dynamic>{
    'flutter.$IS_LOGGED_IN': value,
    'flutter.$USER_ID': '9876543210',
  });
  final preferences = await SharedPreferences.getInstance();
  await preferences.setBool(IS_LOGGED_IN, value);
  await preferences.setString(USER_ID, '9876543210');
}
