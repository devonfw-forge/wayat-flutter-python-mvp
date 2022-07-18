import 'package:flutter/material.dart';


class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WAYAT'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: [
          _invitationCard(),
        ],
      ),
    );
  }

  Widget _invitationCard() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.account_circle, color: Colors.purple,),
            title: Text('User User invited you to this event:'),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.group, color: Colors.purple,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Event',
                      textScaleFactor: 1.5,
                      ),
                      Text('14:30 1/2/22 18:30 2/2/22'),
                    ],
                  ),
                  TextButton(
                    onPressed: (){}, 
                    child: Icon(Icons.location_on, color: Colors.purple,)
                  ),
                ],
              ),
              Divider(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: (){}, 
                    child: Icon(Icons.check, color: Colors.green,),
                  ),
                  TextButton(
                    onPressed: (){}, 
                    child: Icon(Icons.clear, color: Colors.red,),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}