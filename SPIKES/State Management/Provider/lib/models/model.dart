import 'package:flutter/cupertino.dart';

class MyModel with ChangeNotifier { 
  String someValueNow = 'Hello';
  String someValue3 = 'Hello';

  void doSomethingNow() {
    if (someValueNow == 'Goodbye') {someValueNow = 'Hello';}
    else {someValueNow = 'Goodbye';}
    
    print(someValueNow);
    notifyListeners();
  }

  Future<void> doSomething3() async {
    await Future.delayed(Duration(seconds: 3));
    
    if (someValue3 == 'Goodbye') {someValue3 = 'Hello';}
    else {someValue3 = 'Goodbye';}
    
    print(someValue3);
    notifyListeners();
  }
}