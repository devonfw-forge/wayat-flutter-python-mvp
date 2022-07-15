import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'models/my_colors.dart';
=======
import 'models/SampleColors.dart';
>>>>>>> Stashed changes

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< Updated upstream
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyPage());
=======
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SamplePage()
    );
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
    return MyColorsW(
=======
    return ColorsW(
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
    final myColorsW = context.dependOnInheritedWidgetOfExactType<MyColorsW>();
=======

    final colorsW = context.dependOnInheritedWidgetOfExactType<ColorsW>();
>>>>>>> Stashed changes

    return Container(
      width: 70,
      height: 70,
<<<<<<< Updated upstream
      decoration: BoxDecoration(color: myColorsW?.color1),
=======
      decoration: BoxDecoration(
        color: colorsW?.color1
      ),
>>>>>>> Stashed changes
    );
  }
}

class Rectangle2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    final myColorsW = context.dependOnInheritedWidgetOfExactType<MyColorsW>();
=======
    final colorsW = context.dependOnInheritedWidgetOfExactType<ColorsW>();
>>>>>>> Stashed changes

    return Container(
      width: 70,
      height: 70,
<<<<<<< Updated upstream
      decoration: BoxDecoration(color: myColorsW?.color2),
=======
      decoration: BoxDecoration(
        color: colorsW?.color2
      ),
>>>>>>> Stashed changes
    );
  }
}
