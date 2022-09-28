import 'package:flutter/material.dart';
import 'package:wayat/lang/app_localizations.dart';

/// Text login title
class CustomLoginTitle extends StatelessWidget {
  const CustomLoginTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.10,
      child: Text(
        appLocalizations.login,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }
}
