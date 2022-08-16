import 'package:flutter/material.dart';

class ProfileButton extends StatefulWidget {
  const ProfileButton({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  bool active = false;

  void _changeState() {
    setState(() {
      active = !active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: TextButton(
        onPressed: () => {_changeState()},
        child: const Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
    );
  }
}
