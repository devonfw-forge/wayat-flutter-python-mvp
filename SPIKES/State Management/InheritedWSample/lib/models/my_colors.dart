import 'package:flutter/material.dart';

/// InheritedWidget class sample
class MyColorsW extends InheritedWidget {
  const MyColorsW(
      {Key? key,
      required this.color1,
      required this.color2,
      required this.child})
      : super(key: key, child: child);

  final Widget child;
  final Color color1;
  final Color color2;

  static MyColorsW? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyColorsW>();
  }

  @override
  bool updateShouldNotify(MyColorsW oldWidget) {
    return color1 != color2 || color2 != oldWidget.color2;
  }
}
