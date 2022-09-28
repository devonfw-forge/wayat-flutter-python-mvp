import 'package:flutter/material.dart';

/// Textfield with label and a hint inside it
class CustomTextField extends StatelessWidget {
  /// Name of the field showed at beggining of textfield
  final String label;

  /// Value to edit
  final String hint;

  /// Controller for textfield. It allows to listen changes.
  final TextEditingController controller;

  const CustomTextField(
      {required this.controller,
      required this.label,
      required this.hint,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black87,
          width: 1,
        ),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 18)),
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: controller,
                cursorColor: Colors.black87,
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontSize: 18),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black38,
                        fontSize: 18)),
              )),
        )
      ]),
    );
  }
}
