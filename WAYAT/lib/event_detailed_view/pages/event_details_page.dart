import 'package:flutter/material.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({Key? key}) : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  String viewMoreLess = 'more';
  int charactersDescription = 20;

  String eventDescription = 'Culpa consequat aliquip ea id in elit nisi exercitation culpa labore. Consectetur occaecat id excepteur fugiat. Adipisicing occaecat enim sunt exercitation. Esse mollit et incididunt aute voluptate est do et minim elit. Veniam et anim fugiat sint do velit occaecat pariatur pariatur minim pariatur sunt. Lorem mollit do deserunt mollit qui aute.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _eventImage(),
              _eventInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Image _eventImage() {
    return Image.network(
      'https://docs.flutter.dev/cookbook/img-files/effects/parallax/02-singapore.jpg',
      fit: BoxFit.cover,
      height: 250,
      width: double.infinity,
    );
  }

  Padding _eventInfo() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 5.0, left: 20.0, right: 20.0, bottom: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _editButton(),
              _deleteButton(),
            ],
          ),
          const Text('EVENT NAME'),
          const Text('LOCATION'),
          const Text('START DATE - END DATE'),
          _participantsButton(),
          Text('$eventDescription'),
          _viewMoreButton(),
          _eventCreatedInfo(),
        ],
      ),
    );
  }

  TextButton _editButton() {
    return TextButton(
        onPressed: () {},
        child: Row(
          children: const [Icon(Icons.edit), Text(' EDIT')],
        ));
  }

  TextButton _deleteButton() {
    return TextButton(
        onPressed: () {},
        child: Row(
          children: const [
            Icon(
              Icons.cancel,
              color: Colors.red,
            ),
            Text(
              ' DELETE',
              style: TextStyle(color: Colors.red),
            )
          ],
        ));
  }

  ElevatedButton _participantsButton() =>
      ElevatedButton(onPressed: () {}, child: const Text('PARTICIPANTS'));

  TextButton _viewMoreButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            if (viewMoreLess == 'more') {
              viewMoreLess = 'less';
              charactersDescription = 3000;
            } else {
              viewMoreLess = 'more';
              charactersDescription = 20;
            }
          });
        },
        child: Row(
          children: [const Icon(Icons.add), Text('View $viewMoreLess')],
        ));
  }

  Row _eventCreatedInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Created by:'),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.person),
                Text('User User'),
              ],
            ),
            const Text('@username'),
          ],
        )
      ],
    );
  }
}
