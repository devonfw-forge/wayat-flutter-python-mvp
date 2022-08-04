import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/features/authentication/common/login_title.dart';
import 'package:wayat/common/widgets/components/wayat_title.dart';
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
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: MediaQuery.of(context).size.height * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomWayatTitle(),
              const CustomLoginTitle(),
              _phoneDescription(),
              _formPhone(),
            ],
          ),
        ),
      ),
    );
  }

  Container _phoneDescription() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Text(
            appLocalizations.phoneVerificationTitle,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(appLocalizations.phoneVerificationDescription,
              textAlign: TextAlign.center),
          const SizedBox(
            height: 25,
          ),
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

  IntlPhoneField _phoneInput() {
    return IntlPhoneField(
      decoration: InputDecoration(
          labelText: 'Phone Number',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      initialCountryCode: 'ES',
      onChanged: (phone) {
        setState(() {
          validPhone = _formKey.currentState!.validate();
        });
      },
    );
  }

  Container _submitButton() {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: CustomOutlinedButton(
        onPressed: !validPhone ? null : _submit,
        text: appLocalizations.sendPhoneButton,
      ),
    );
  }

  _submit() {
    userSession.setPhoneValidation(_formKey.currentState!.validate());
  }
}
