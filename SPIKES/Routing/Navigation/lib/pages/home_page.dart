import 'package:flutter/material.dart';


class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Scafold Page'),
                /*
                  ON CLICK WE WILL OPEN THE SCREEN WE WANT
                */
                onPressed: (){
                  Navigator.pushNamed(context, 'scaffold');
                }, 
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                child: Text('Square Page'),
                /*
                  ON CLICK WE WILL OPEN THE SCREEN WE WANT
                */
                onPressed: (){
                  Navigator.pushNamed(context, 'square');
                }, 
              ),
            ],
          ),
      ),
   );
  }
}