import 'package:flutter/material.dart';
import 'package:wayat/lang/app_localizations.dart';

class ChangePhoneField extends StatelessWidget {
  const ChangePhoneField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            appLocalizations.changePhone,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: InkWell(
              onTap: () {
                //AutoRoute to change phone page
              },
              child: const Icon(Icons.arrow_forward,
                  color: Colors.black87, size: 24)),
        )
      ],
    );
  }
}
