import 'package:flutter/material.dart';
import 'package:inherited_sample/models/sample_colors.dart';
import 'package:inherited_sample/widgets/rectangle_down.dart';
import 'package:inherited_sample/widgets/rectangle_up.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({Key? key}) : super(key: key);

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
          children: const [
            RectangleUp(), 
            RectangleDown()
          ],
        )),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.contacts),
            onPressed: () {
              setState(() {
                if (color1 != Colors.pink) {
                  color1 = Colors.pink;
                } else {
                  color1 = Colors.green;
                }
                if (color2 != Colors.purple) {
                  color2 = Colors.purple;
                } else {
                  color2 = Colors.red;
                }
              });
            }),
      ),
    );
  }
}
