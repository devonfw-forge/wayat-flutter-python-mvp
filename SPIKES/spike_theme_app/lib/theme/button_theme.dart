import 'package:flutter/material.dart';

class CustomButtonTheme {
  static ButtonThemeData get lightTheme {
    return ButtonThemeData(
        textTheme: ButtonTextTheme.normal,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
        buttonColor: Colors.black);
  }

  static ButtonThemeData get darkTheme {
    return ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
      buttonColor: Colors.black,
    );
  }
}
