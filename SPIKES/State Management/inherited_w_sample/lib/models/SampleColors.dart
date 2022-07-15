import 'package:flutter/material.dart';

/// InheritedWidget class sample
class ColorsW extends InheritedWidget {
  ColorsW({
    Key? key,
    required this.color1, 
    required this.color2, 
    required this.child}
  ) : super(key: key, child: child);

  final Widget child;
  final Color color1;
  final Color color2;

  static ColorsW? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ColorsW>();
  }

  @override
  bool updateShouldNotify(ColorsW oldWidget) {
    return color1 != color2
      || color2 != oldWidget.color2;
  }
}