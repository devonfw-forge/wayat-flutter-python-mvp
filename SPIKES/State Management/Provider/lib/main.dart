import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/model.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider<MyModel>(
            create: ( _ ) => MyModel(),
            lazy: false,
          ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('My App')),
        body: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.green[200],
                  child: Consumer<MyModel>(
                    builder: (context, myModel, child) {
                      return ElevatedButton(
                        child: Text('Do something now'),
                        onPressed: () {
                          myModel.doSomethingNow();
                        },
                      );
                    }
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(35),
                  color: Colors.blue[200],
                  child: Consumer<MyModel>(
                    builder: (context, myModel, child) {
                      return Text(myModel.someValueNow);
                    }
                  ),
                ),

              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.green[200],
                  child: Consumer<MyModel>(
                    builder: (context, myModel, child) {
                      return ElevatedButton(
                        child: Text('Do something in 3 secs'),
                        onPressed: () {
                          myModel.doSomething3();
                        },
                      );
                    }
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(35),
                  color: Colors.blue[200],
                  child: Consumer<MyModel>(
                    builder: (context, myModel, child) {
                      return Text(myModel.someValue3);
                    }
                  ),
                ),

              ],
            ),
          ],
          
        ),
      ),
    );
  }
}