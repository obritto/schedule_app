import 'package:flutter/material.dart';
import 'package:schedule_app/views/schedule_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Schedule',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SchedulePage(),
    );
  }
}
