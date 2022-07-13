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
      /* 
        FIRST PAGE APPEARING 
      */
      initialRoute: 'home',
      /* 
        ROUTE NAMES TO CALL THEM LATER 
      */
      routes: {
        'home'    :(context) => MyHomePage(),
        'scaffold': (context) => ScaffoldPage(),
        'square'  :(context) => SquarePage(),
      },
      /* 
        WHEN CALLED A NO EXISTING ROUTE, THE APP WILL REDIRECT TO THIS ROUTE 
      */
      onGenerateRoute: (settings){
        return MaterialPageRoute(
          builder: (context) => MyHomePage(),
        );
      },
    );
  }
}