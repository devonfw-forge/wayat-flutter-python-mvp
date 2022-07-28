import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/models/lastName_model.dart';

import 'models/name_model.dart';

void main() => runApp(AppState());

/*
  CREATE AN INTERMEDIATE WIDGET TO MANAGE THE APP STATE
*/
class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    /*
      USE MULTIPROVIDER TO PUT ALL THE INFO YOU NEED.
      EACH MODEL IS A DIFFERENT PROVIDER  
    */
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20),
                  /*
                    USE THE CONSUMER<PROVIDER-YOU-NEED> WIDGET TO PASS THE INFO YOU WANT
                  */
                  child: Consumer<NameModel>(
                    builder: (context, nameModel, child) {
                      return ElevatedButton(
                        child: Text('Get Name'),
                        onPressed: () {
                          /*
                            ONCE YOU GET THE INFO YOU CAN CALL THE METHODS OF THE PROVIDER
                          */
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
                      /*
                        YOU ALSO CAN CALL VARIABLES FROM THE PROVIDER
                      */
                      return Text(nameModel.name);
                    }
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20),
                  /*
                    HERE WE CHANGE THE PROVIDER
                  */
                  child: Consumer<LastNameModel>(
                    builder: (context, myModel, child) {
                      return ElevatedButton(
                        child: Text('Get Last Name'),
                        onPressed: () {
                          /*
                            HERE WE CAN USE THE METHODS OF THE SECOND PROVIDER
                          */
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
                      /*
                        AND HERE WE USE THE VARIABLE OF THE SECOND PROVIDER
                      */
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