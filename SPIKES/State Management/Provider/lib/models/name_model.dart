import 'package:flutter/material.dart';

class NameModel with ChangeNotifier { 
  String name = 'Insert Name';

  void getName() {
    name = 'John';
    
    notifyListeners();
  }
}