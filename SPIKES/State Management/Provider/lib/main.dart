import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/models/lastName_model.dart';

import 'models/name_model.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider<NameModel>(
            create: ( _ ) => NameModel(),
            lazy: false,
          ),
          ChangeNotifierProvider<LastNameModel>(
            create: ( _ ) => LastNameModel(),
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
                  child: Consumer<NameModel>(
                    builder: (context, nameModel, child) {
                      return ElevatedButton(
                        child: Text('Get Name'),
                        onPressed: () {
                          nameModel.getName();
                        },
                      );
                    }
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(35),
                  child: Consumer<NameModel>(
                    builder: (context, nameModel, child) {
                      return Text(nameModel.name);
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
                  child: Consumer<LastNameModel>(
                    builder: (context, myModel, child) {
                      return ElevatedButton(
                        child: Text('Get Last Name'),
                        onPressed: () {
                          myModel.getLastName();
                        },
                      );
                    }
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(35),
                  child: Consumer<LastNameModel>(
                    builder: (context, myModel, child) {
                      return Text(myModel.lastName);
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