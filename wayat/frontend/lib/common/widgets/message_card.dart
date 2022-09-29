import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';

/// Message wrapped in a Card
class MessageCard extends StatelessWidget {
  /// Message content
  final String text;

  /// Height of the card
  final double height;

  const MessageCard(this.text, {double? height, Key? key})
      : height = height ?? 75,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorTheme.secondaryColorDimmed),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
