import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:test/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  // fake String from a HTTP request
  final json_user =
      '{"name": "John", "address": {"street": "My st.", "city": "New York"}}';

  @override
  Widget build(BuildContext context) {
    // Decode string into a map
    Map<String, dynamic> userMap = jsonDecode(json_user);
    // Creates the object using the method fromJson
    final user = User.fromJson(userMap);
    return Scaffold(
      appBar: AppBar(
        title: const Text("JSON Serialization"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('${user.name} ${user.address.city}')],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
