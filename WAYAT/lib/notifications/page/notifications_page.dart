import 'package:flutter/material.dart';


class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final String eventName = 'Event';
    final String eventDate = '14:30 1/2/22 18:30 2/2/22';

    return ListView(
        padding: EdgeInsets.all(10.0),
        children: [
          _invitationEventCard(eventName, eventDate),
          _startEventCard(eventName, eventDate),
          _cancelEventCard(eventName, eventDate),
          _invitationEventCard(eventName, eventDate),
          _startEventCard(eventName, eventDate),
          _cancelEventCard(eventName, eventDate),
        ],
      );
  }

  Card _invitationEventCard(String eventName, String eventDate) {
    return Card(
      elevation: 5.0,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('User User invited you to this event:'),
          ),
          Column(
            children: [
              _eventInfo(eventName, eventDate),
              Divider(),
              _eventButtons(),
            ],
          )
        ],
      ),
    );
  }


  Card _startEventCard(String eventName, String eventDate) {
    return Card(
      elevation: 5.0,
      child: Column(
        children: [
          ListTile(
            title: Text('This event will start soon:'),
          ),
          _eventInfo(eventName, eventDate),
          SizedBox(height: 10.0,),
        ],
      ),
    );
  }


  Card _cancelEventCard(String eventName, String eventDate) {
    return Card(
      elevation: 5.0,
      child: Column(
        children: [
          ListTile(
            title: Text('This event has been canceled:'),
          ),
          _redEventInfo(eventName, eventDate),
          SizedBox(height: 10.0,),
        ],
      ),
    );
  }

  Row _eventInfo(String eventName, String eventDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.group),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(eventName,
            textScaleFactor: 1.5,
            ),
            Text(eventDate),
          ],
        ),
        TextButton(
          onPressed: (){}, 
          child: Icon(Icons.location_on)
        ),
      ],
    );
  }

  Row _eventButtons() {
    return Row(
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
    );
  }

  Row _redEventInfo(String eventName, String eventDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.group),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(eventName,
            textScaleFactor: 1.5,
            style: TextStyle(color: Colors.red),
            ),
            Text(
              eventDate,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        TextButton(
          onPressed: (){}, 
          child: Icon(Icons.location_on)
        ),
      ],
    );
  }
}