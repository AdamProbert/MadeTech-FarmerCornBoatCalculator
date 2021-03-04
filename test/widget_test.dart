// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:Ferrynuff/main.dart';

void main() {
  group('1:1', () {
    num gooseCount = 1;
    num cornCount = 1;
    num rhinoCount = 0;

    test('not too much corn', () async {
      expect(tooMuchCorn(cornCount, gooseCount), false);
    });

    test('not too many geese', () async {
      expect(tooManyGeese(gooseCount, cornCount, rhinoCount), false);
    });

    test('is valid passengers', () async {
      expect(validPassengers(cornCount, gooseCount, rhinoCount), true);
    });
  });

  group('2:1 geese vs corn', () {
    num gooseCount = 2;
    num cornCount = 1;
    num rhinoCount = 0;

    test('not too much corn', () async {
      expect(tooMuchCorn(cornCount, gooseCount), false);
    });

    test('not too many geese', () async {
      expect(tooManyGeese(gooseCount, cornCount, rhinoCount), false);
    });

    test('is valid passengers', () async {
      expect(validPassengers(cornCount, gooseCount, rhinoCount), true);
    });
  });

  group('2:1 corn vs geese', () {
    num gooseCount = 1;
    num cornCount = 2;
    num rhinoCount = 0;

    test('not too much corn', () async {
      expect(tooMuchCorn(cornCount, gooseCount), false);
    });

    test('not too many geese', () async {
      expect(tooManyGeese(gooseCount, cornCount, rhinoCount), false);
    });

    test('is valid passengers', () async {
      expect(validPassengers(cornCount, gooseCount, rhinoCount), true);
    });
  });

  group('2:2', () {
    num gooseCount = 2;
    num cornCount = 2;
    num rhinoCount = 0;

    test('not too much corn', () async {
      expect(tooMuchCorn(cornCount, gooseCount), true);
    });

    test('not too many geese', () async {
      expect(tooManyGeese(gooseCount, cornCount, rhinoCount), true);
    });

    test('is valid passengers', () async {
      expect(validPassengers(cornCount, gooseCount, rhinoCount), false);
    });
  });

  test('1 corn and >2 geese cannot travel', () async {
    num gooseCount = 34;
    num cornCount = 1;
    num rhinoCount = 0;
    expect(validPassengers(gooseCount, cornCount, rhinoCount), false);
  });

  test('1 goose and >2 corn cannot travel', () async {
    num gooseCount = 1;
    num cornCount = 37;
    num rhinoCount = 0;
    expect(validPassengers(gooseCount, cornCount, rhinoCount), false);
  });

  test('0 corn and >1 geese cannot travel', () async {
    num gooseCount = 34;
    num cornCount = 0;
    num rhinoCount = 0;
    expect(validPassengers(gooseCount, cornCount, rhinoCount), true);
  });

  test('0 goose and >1 corn cannot travel', () async {
    num gooseCount = 0;
    num cornCount = 37;
    num rhinoCount = 0;
    expect(validPassengers(gooseCount, cornCount, rhinoCount), true);
  });

  group('1:1:1', () {
    num gooseCount = 1;
    num cornCount = 1;
    num rhinoCount = 1;

    test('is valid passengers', () async {
      expect(validPassengers(cornCount, gooseCount, rhinoCount), true);
    });
  });

  group('at least 1 of each but more of one', () {
    num gooseCount = 1;
    num cornCount = 2;
    num rhinoCount = 1;

    test('is valid passengers', () async {
      expect(validPassengers(cornCount, gooseCount, rhinoCount), false);
    });
  });

  group('much corn and many rhinos', () {
    num gooseCount = 0;
    num cornCount = 20;
    num rhinoCount = 5;

    test('is valid passengers', () async {
      expect(validPassengers(cornCount, gooseCount, rhinoCount), true);
    });
  });

  group('2 rhino and 1 goose', () {
    num gooseCount = 1;
    num cornCount = 0;
    num rhinoCount = 2;

    test('is valid passengers', () async {
      expect(validPassengers(cornCount, gooseCount, rhinoCount), true);
    });
  });

  group('3 rhino and 1 goose', () {
    num gooseCount = 1;
    num cornCount = 0;
    num rhinoCount = 3;

    test('is valid passengers', () async {
      expect(validPassengers(cornCount, gooseCount, rhinoCount), false);
    });
  });

  group('one rhino and two geese', () {
    num gooseCount = 2;
    num cornCount = 0;
    num rhinoCount = 1;

    test('is valid passengers', () async {
      expect(validPassengers(cornCount, gooseCount, rhinoCount), true);
    });
  });

  group('one rhino and 3 geese', () {
    num gooseCount = 3;
    num cornCount = 0;
    num rhinoCount = 1;

    test('is valid passengers', () async {
      expect(validPassengers(cornCount, gooseCount, rhinoCount), false);
    });
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
