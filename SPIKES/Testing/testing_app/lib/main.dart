import 'package:flutter/material.dart';
import 'package:testing_app/src/page/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: LoginPage()),
      debugShowCheckedModeBanner: false,
    );
  }
}