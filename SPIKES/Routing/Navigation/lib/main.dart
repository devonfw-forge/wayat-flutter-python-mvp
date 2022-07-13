import 'package:flutter/material.dart';

import 'pages/scaffold_page.dart';
import 'pages/square_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigator Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      initialRoute: 'home',
      routes: {
        'home'    :(context) => MyHomePage(),
        'scaffold': (context) => ScaffoldPage(),
        'square'  :(context) => SquarePage(),
      },
      onGenerateRoute: (settings){
        return MaterialPageRoute(
          builder: (context) => MyHomePage(),
        );
      },
    );
  }
}