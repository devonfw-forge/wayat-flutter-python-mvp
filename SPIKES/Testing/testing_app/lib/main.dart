import 'package:flutter/material.dart';
import 'package:testing_app/src/page/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: TestWidget(title: 'Hello World', message: 'Hello'),
      ),
    );
  }
}