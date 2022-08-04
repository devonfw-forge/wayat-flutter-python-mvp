import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/lang/lang_singleton.dart';

class PhoneValidationPage extends StatefulWidget {
  const PhoneValidationPage({Key? key}) : super(key: key);

  @override
  State<PhoneValidationPage> createState() => _PhoneValidationPageState();
}

class _PhoneValidationPageState extends State<PhoneValidationPage> {
  final appLocalizations = GetIt.I.get<LangSingleton>().appLocalizations;
  final userSession = GetIt.I.get<SessionState>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool validPhone = false;

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
              _formPhone(),
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
            color: ColorTheme.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 28),
      ),
    );
  }

  SizedBox _loginTitle() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Text(
        appLocalizations.login,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  Container _phoneDescription() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Column(
        children: [
          Text(
            appLocalizations.phoneVerificationTitle,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(appLocalizations.phoneVerificationDescription, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Form _formPhone() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            _phoneInput(),
            _submitButton(),
          ],
        ));
  }

  Container _phoneInput() {
    return Container(
        child: IntlPhoneField(
      decoration: InputDecoration(
          labelText: 'Phone Number',
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          )),
      initialCountryCode: 'ES',
      onChanged: (phone) {
        if (_formKey.currentState!.validate()) {
          validPhone = true;
        }
        setState(() {});
      },
    ));
  }

  Container _submitButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: ElevatedButton(
        onPressed: !validPhone ? null : _submit,
        child: Text(appLocalizations.sendPhoneButton),
      ),
    );
  }

  _submit() {
    userSession.setPhoneValidation(_formKey.currentState!.validate());
  }
}
