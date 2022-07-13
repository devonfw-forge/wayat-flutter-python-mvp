import 'package:flutter/material.dart';

/*
  USE THE CHANGENOTIFIER TO ALERT THE APP THAT HERE ARE A PROVIDER WITH INFORMATION
*/
class NameModel with ChangeNotifier { 
  String name = 'Insert Name';

  void getName() {
    name = 'John';
    /*
      ONCE YOU HAVE THE INFORMATION YOU MUST USE NOTIFYLISTENERS() TO TELL THE APP THAT 
      THE INFO CHANGED AND IT HAS TO BE PRINTED AGAIN
    */
    notifyListeners();
  }
}