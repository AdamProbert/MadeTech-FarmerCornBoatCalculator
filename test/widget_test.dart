// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app/main.dart';

void main() {
  test('2 geese and x+1 corn is too many geese', () async {
    num gooseCount = 2;
    num cornCount = 2;
    expect(tooManyGeese(gooseCount, cornCount), true);
  });

  test('2 corn and x+1 geese is too much corn', () async {
    num gooseCount = 2;
    num cornCount = 2;
    expect(tooManyGeese(gooseCount, cornCount), true);
  });

  test('transport 56346 geese should cost', () async {
    expect(calculateGooseCost(56346), 28173.0);
  });

  test('transport 5 geese should cost', () async {
    expect(calculateGooseCost(5), 2.5);
  });

  test('transport 3 geese should cost', () async {
    expect(calculateGooseCost(3), 1.5);
  });

  test('transport 1 geese should cost', () async {
    expect(calculateGooseCost(1), .5);
  });

  test('transport 56346 corn should cost', () async {
    expect(calculateCornCost(56346), 28173.0);
  });

  test('transport 5 corn should cost', () async {
    expect(calculateCornCost(5), 2.5);
  });

  test('transport 3 corn should cost', () async {
    expect(calculateCornCost(3), 1.5);
  });

  test('transport 1 corn should cost', () async {
    expect(calculateCornCost(1), .5);
  });

  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());
  //
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
}
