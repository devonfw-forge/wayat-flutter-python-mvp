import 'package:flutter/material.dart';

class _ContactProfile extends StatelessWidget {
  const _ContactProfile({Key? key}) : super(key: key);
  final double profileHeight = 120;
  final double buttonsHorizontalPadding = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const SizedBox(height: 30),
      _userAvatar(),
      const SizedBox(height: 8),
      _userFirstLastName(),
      const SizedBox(height: 8),
      _userNickName(),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buttonEvent(),
          Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: buttonsHorizontalPadding)),
          _buttonMap(),
        ],
      ),
      Divider(thickness: 2, color: Colors.grey.shade400),
    ])));
  }

  CircleAvatar _userAvatar() {
    return CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: const NetworkImage(
          'https://commons.wikimedia.org/wiki/File:Font_Awesome_5_solid_user-circle.svg'),
    );
  }

  Text _userFirstLastName() {
    return const Text('Usuario Usuario',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold));
  }

  Text _userNickName() {
    return const Text('@username',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal));
  }

  TextButton _buttonEvent() {
    return TextButton(
        child: const Text('EVENTOS'),
        onPressed: () {
          //implement function
        });
  }

  TextButton _buttonMap() {
    return TextButton(
        child: const Text('MAPA'),
        onPressed: () {
          //implement function
        });
  }
}

class _ContactEventsList extends StatelessWidget {
  const _ContactEventsList({
    Key? key,
    required this.avatar,
    required this.title,
    required this.date,
  }) : super(key: key);

  final Widget avatar;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: avatar, //Event rounded avatar
          ),
          Expanded(
            flex: 3,
            child: _EventDescriprion(
              //Eventos and calendar date titles
              title: title,
              date: date,
            ),
          ),
          const Icon(
            //locationIcon
            Icons.location_city_rounded,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}

class _EventDescriprion extends StatelessWidget {
  const _EventDescriprion({
    Key? key,
    required this.title,
    required this.date,
  }) : super(key: key);

  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            date,
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}

class ContactDetailPage extends StatelessWidget {
  const ContactDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _ContactProfile(),
        ListView(
          children: [
            _ContactEventsList(
              avatar: Container(
                decoration: const BoxDecoration(color: Colors.yellow),
              ),
              title: 'Evento',
              date: '14.30 01/02/2022',
            ),
          ],
        )
      ],
    );
  }
}
