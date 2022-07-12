import 'package:flutter/material.dart';

import '../fluro_router.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
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
            child: const Text("ir para home"),
            onPressed: () => Navigator.pushNamed(context, 'home'),
          ),
        ),
      ),
    );
  }
}
