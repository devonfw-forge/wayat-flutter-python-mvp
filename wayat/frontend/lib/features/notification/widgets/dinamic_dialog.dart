// ignore_for_file: public_member_api_docs, sort_constructors_first
//push notification dialog for foreground
import 'package:flutter/material.dart';

class DynamicDialog extends StatefulWidget {
  final title;
  final body;

  DynamicDialog({super.key, this.title, this.body});

  @override
  _DynamicDialogState createState() => _DynamicDialogState();
}

class _DynamicDialogState extends State<DynamicDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      actions: <Widget>[
        OutlinedButton.icon(
            label: const Text('Close'),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close))
      ],
      content: Text(widget.body),
    );
  }
}
