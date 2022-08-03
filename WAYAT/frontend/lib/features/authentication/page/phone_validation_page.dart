import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/lang/lang_singleton.dart';

class PhoneValidationPage extends StatefulWidget {
  const PhoneValidationPage({Key? key}) : super(key: key);

  @override
  State<PhoneValidationPage> createState() => _PhoneValidationPageState();
}

class _PhoneValidationPageState extends State<PhoneValidationPage> {
  final _phoneController = TextEditingController();
  bool _isPhoneValid = false;
  final appLocalizations = GetIt.I.get<LangSingleton>().appLocalizations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.2,
              vertical: MediaQuery.of(context).size.height * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _logoWayat(),
              _loginTitle(),
              _phoneDescription(),
              _phoneInput(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _logoWayat() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Text(
        appLocalizations.appTitle,
        style: const TextStyle(
            color: ColorTheme.primaryColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  SizedBox _loginTitle() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Text(
        appLocalizations.login,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Column _phoneDescription() {
    return Column(
      children: [
        Text('Phone verification'),
        Text('A verification code will be send to your phone'),
      ],
    );
  }

  Container _phoneInput() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: IntlPhoneField(
          decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              )),
          initialCountryCode: 'ES',
          onChanged: (phone) {
            print(phone.completeNumber);
          },
        ));
  }
}
