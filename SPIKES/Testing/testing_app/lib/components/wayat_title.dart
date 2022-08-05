import 'package:flutter/material.dart';

class CustomWayatTitle extends StatelessWidget {
  const CustomWayatTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Text(
        'wayat',
        style: const TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
            fontSize: 28),
      ),
    );
  }
}