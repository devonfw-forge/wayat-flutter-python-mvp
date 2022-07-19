import 'package:flutter/material.dart';


class EventDetailsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){}, 
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          Text('EDIT')
                        ],
                      )
                    ),
                    TextButton(
                      onPressed: (){}, 
                      child: Row(
                        children: [
                          Icon(Icons.cancel, color: Colors.red,),
                          Text('DELETE', style: TextStyle(color: Colors.red),)
                        ],
                      )
                    ),
                  ],
                ),
                Text('EVENT NAME'),
                Text('LOCATION'),
                Text('START DATE - END DATE'),
                ElevatedButton(onPressed: (){}, child: Text('PARTICIPANTS')),
                Text('Culpa consequat aliquip ea id in elit nisi exercitation culpa labore. Consectetur occaecat id excepteur fugiat. Adipisicing occaecat enim sunt exercitation. Esse mollit et incididunt aute voluptate est do et minim elit. Veniam et anim fugiat sint do velit occaecat pariatur pariatur minim pariatur sunt. Lorem mollit do deserunt mollit qui aute.'),
                TextButton(
                  onPressed: (){}, 
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text('View more')
                    ],
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Created by:'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.person),
                          Text('User User'),
                        ],
                      ),
                      Text('@username'),
                    ],)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
   );
  }
}