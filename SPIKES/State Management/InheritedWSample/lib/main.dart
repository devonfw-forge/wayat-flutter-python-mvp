import 'package:flutter/material.dart';
import 'models/MisColores.dart';

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
      home: MyPage()
    );
  }
}

class MyPage extends StatefulWidget {
  MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Color color1 = Colors.redAccent;
  Color color2 = Colors.teal;
  @override
  Widget build(BuildContext context) {
    return MisColoresW(
      color1: color1,
      color2: color2,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Rectangle1(),
              Rectangle2()
            ],
          )
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.contacts),
          onPressed: () {
            setState(() {
              color1 = Colors.pink;
              color2 = Colors.purple;
            });
          }
        ),
      ),
    );
  }
}

class Rectangle1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final misColoresW = context.dependOnInheritedWidgetOfExactType<MisColoresW>();

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: misColoresW?.color1
      ),
    );
  }
}

class Rectangle2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final misColoresW = context.dependOnInheritedWidgetOfExactType<MisColoresW>();

  return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: misColoresW?.color2
      ),
    );
  }
}