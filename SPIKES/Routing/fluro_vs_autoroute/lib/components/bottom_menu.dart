import 'package:flutter/material.dart';

class BottomMenuComponent extends StatelessWidget {
  const BottomMenuComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Menu Page')),
      body: const Center(
        child: Text("First bottom item"),
      ),
    );
  }
}
