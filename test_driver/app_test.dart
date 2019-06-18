import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Schedule App', () {
    final buttonAddFinder = find.byValueKey('buttonAdd');
    final titleScheduleFinder = find.byValueKey('titleSchedule');
    final titleSchedulingDetails = find.byValueKey("titleSchedulingDetails");
    final textDescription = find.byValueKey("textDescription");

    final textFieldDescriptionFinder = find.byValueKey('textFieldDescription');
    final switchOkFinder = find.byValueKey('switchOk');
    final buttonRemoveFinder = find.byValueKey('buttonRemove');
    final buttonSaveFinder = find.byValueKey('buttonSave');


    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Should viewing the Schedule page', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(titleScheduleFinder), "Schedule");
    });

    test('Should must press the add button', () async {
      // First, tap the button.
      await driver.tap(buttonAddFinder);
    });

    test('Should viewing the Scheduling Details page', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(titleSchedulingDetails), "Scheduling Details");
    });

    test('Should complete the form with some data and save', () async {

      await driver.tap(textFieldDescriptionFinder);
      driver.enterText('Test');
      await driver.tap(switchOkFinder);

      await driver.tap(buttonSaveFinder);
    });

    test('Should viewing the Schedule page', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(titleScheduleFinder), "Schedule");
    });

    test('Should select item', () async {
      await driver.tap(textFieldDescriptionFinder);
    });

    test('Should delete item', () async {
        await driver.tap(buttonRemoveFinder);
    });

  });
}