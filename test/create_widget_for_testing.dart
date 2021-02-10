
import 'package:bluestacks_assignment/util/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpWidget(
    {@required WidgetTester tester, @required Widget widget}) async {
  await tester.pumpWidget(createWidgetForTesting(child: widget));
}

Widget createWidgetForTesting({@required Widget child}) {
  return MediaQuery(
    data: const MediaQueryData(),
    child: MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          child: child,
        ),
      ),
      routes: routeNames,
    ),
  );
}