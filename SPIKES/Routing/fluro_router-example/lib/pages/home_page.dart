import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../fluro_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Routes.defineRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: ElevatedButton(
            child: const Text("ir para page two"),
            onPressed: () => Navigator.pushNamed(context, 'pagetwo'),
          ),
        ),
      ),
    );
  }
}
