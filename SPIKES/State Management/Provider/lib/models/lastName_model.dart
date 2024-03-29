import 'package:flutter/material.dart';

class LastNameModel with ChangeNotifier { 
  String lastName = 'Insert Last Name';

  /*
    YOU CAN USE A FUTURE METHOD
  */
  Future<void> getLastName() async {
    await Future.delayed(Duration(seconds: 1));
    
    lastName = 'Smith';
    
    notifyListeners();
  }
}