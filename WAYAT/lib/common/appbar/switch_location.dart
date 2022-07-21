import 'package:flutter/material.dart';

class LocationSwitch extends StatefulWidget {
  const LocationSwitch({Key? key}) : super(key: key);

  @override
  State<LocationSwitch> createState() => _LocationSwitchState();
}

class _LocationSwitchState extends State<LocationSwitch> {
  bool _activated = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _activated
            ? const Icon(Icons.location_on)
            : const Icon(Icons.location_off_outlined),
        Switch(
            value: _activated,
            onChanged: (bool newValue) {
              setState(() {
                _activated = newValue;
              });
            })
      ],
    );
  }
}
