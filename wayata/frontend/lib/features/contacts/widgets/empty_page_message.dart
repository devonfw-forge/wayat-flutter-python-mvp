import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';

class EmptyPageMessage extends StatelessWidget {
  final String message;

  const EmptyPageMessage({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 75,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: ColorTheme.secondaryColorDimmed),
        child: Center(
            child: Text(
          message,
          style: const TextStyle(
              fontSize: 18, color: Colors.black45, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
