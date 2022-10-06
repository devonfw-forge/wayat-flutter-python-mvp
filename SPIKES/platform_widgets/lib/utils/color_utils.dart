library colorutils;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

////Color utilities
final materialThemeData = ThemeData(
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.white,
    accentColor: Colors.deepOrange,
    appBarTheme: AppBarTheme(color: Colors.deepOrange),
    primaryColor: Colors.redAccent,
    secondaryHeaderColor: Colors.deepOrange,
    textTheme: TextTheme().copyWith(bodyText1: TextTheme().bodyText2));

final cupertinoTheme = CupertinoThemeData(
    primaryColor: Colors.redAccent,
    barBackgroundColor: Colors.deepOrange,
    primaryContrastingColor: Colors.redAccent,
    scaffoldBackgroundColor: Colors.white);

final toolbarTextStyle = TextStyle(color: Colors.white, fontSize: 16.0);
final textStyleBlackPlain = TextStyle(color: Colors.black, fontSize: 30);
final bottomTabsBackground = Colors.blueGrey;
final bottomNavTextStyle = TextStyle(color: Colors.white, fontSize: 14.0);
final toolbarButtonTextStyle = TextStyle(color: Colors.white, fontSize: 14.0);
final tabsContentText = TextStyle(color: Colors.brown, fontSize: 30);
