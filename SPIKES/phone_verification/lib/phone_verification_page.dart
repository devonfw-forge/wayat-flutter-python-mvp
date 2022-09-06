import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
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
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 150),
                    _phoneInput(),
                    _submitButton(),
                  ],
                ))));
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

  Container _submitButton() {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: OutlinedButton(
        onPressed: (() async {}),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000.0),
          ),
        ),
        child: Text('Verify'),
      ),
    );
  }
}
