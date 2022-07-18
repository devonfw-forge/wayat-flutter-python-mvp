import 'package:flutter/material.dart';
import 'models/SampleColors.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SamplePage()
    );
  }
}

class SamplePage extends StatefulWidget {
  SamplePage({Key? key}) : super(key: key);

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  Color color1 = Colors.redAccent;
  Color color2 = Colors.teal;
  
  @override
  Widget build(BuildContext context) {
    return ColorsW(
      color1: color1,
      color2: color2,
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Rectangle1(), Rectangle2()],
        )),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.contacts),
            onPressed: () {
              setState(() {
                color1 = Colors.pink;
                color2 = Colors.purple;
              });
            }),
      ),
    );
  }
}

class Rectangle1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final colorsW = context.dependOnInheritedWidgetOfExactType<ColorsW>();

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: colorsW?.color1
      ),
    );
  }
}

class Rectangle2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorsW = context.dependOnInheritedWidgetOfExactType<ColorsW>();

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: colorsW?.color2
      ),
    );
  }
}
