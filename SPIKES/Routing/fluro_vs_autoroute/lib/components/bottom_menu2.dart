import 'package:flutter/material.dart';

class BottomMenuSecondComponent extends StatelessWidget {
  const BottomMenuSecondComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Menu Page')),
      body: const Center(
        child: Text("Second bottom item"),
      ),
    );
  }
}
