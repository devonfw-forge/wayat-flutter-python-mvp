import 'package:flutter/material.dart';
import 'package:inherited_sample/models/sample_colors.dart';

class RectangleDown extends StatelessWidget {
  const RectangleDown({Key? key}) : super(key: key);

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