import 'package:flutter/material.dart';
import 'package:test_fluro_router/fluro_router.dart';

import 'fluro_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Routes.defineRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test fluro',
      initialRoute: 'home',
      onGenerateRoute: Routes.router.generator,
    );
  }
}
