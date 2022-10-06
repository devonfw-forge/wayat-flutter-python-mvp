import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:spike_push_notifications/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
        child: MaterialApp(
      title: 'Notify',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ));
  }
}
