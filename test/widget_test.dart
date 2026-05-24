import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cherry_coffee_ordering_application/main.dart';

void main() {
  testWidgets('shows the login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Cherry Coffee Login'), findsOneWidget);
    expect(find.text('Cherry Coffee'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    expect(find.text('Create new account'), findsOneWidget);
  });
}
