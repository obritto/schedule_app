import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schedule_app/widgets/button_widget.dart';

void main() {
  testWidgets('ButtonWidget has a title and icon', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: AppBar(
            title: Text(''),
          ),
          body: Center(
            child: ButtonWidget(
              title: 'Test',
              icon: Icon(
                Icons.check,
              ),
            ),
          ),
        )));

    final titleFinder = find.text('Test');
    final iconFinder = find.byIcon(Icons.check);

    expect(titleFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
  });
}
