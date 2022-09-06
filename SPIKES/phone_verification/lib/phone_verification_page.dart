import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({Key? key}) : super(key: key);

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _validPhone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: _phoneInput()));
  }

  IntlPhoneField _phoneInput() {
    return IntlPhoneField(
      // Only numbers are allowed as input
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: InputDecoration(
          errorText: 'Enter valid phone number',
          labelText: 'Enter phone number',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      initialCountryCode: 'ES',
      onChanged: (phone) {},
    );
  }
}
