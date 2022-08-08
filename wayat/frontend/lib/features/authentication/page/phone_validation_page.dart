import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool _validPhone = false;
  String _phoneNumber = "";
  String _errorPhoneMsg = "";

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
      // Only numbers are allowed as input 
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: InputDecoration(
          errorText: _errorPhoneMsg != "" ? _errorPhoneMsg : null,
          labelText: appLocalizations.phoneNumber,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      initialCountryCode: 'ES',
      onChanged: (phone) {
        setState(() {
          _validPhone = _formKey.currentState!.validate();
          if (_validPhone) _phoneNumber = phone.completeNumber;
        });
      },
    );
  }

  Container _submitButton() {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: CustomOutlinedButton(
        onPressed: !_validPhone ? null : _submit,
        text: appLocalizations.sendVerification,
      ),
    );
  }

  _submit() async {
    if (_formKey.currentState!.validate() && _phoneNumber != "") {
      try{
        await userSession.phoneService.sendGoogleSMSCode(
          phoneNumber: _phoneNumber,
          verificationFailed: _phoneCodeFailed,
          codeTimeout: _phoneCodeTimeout
        );
        userSession.phoneNumber = _phoneNumber;
      } on FirebaseAuthException catch (e) {
        if (e.code == "invalid-phone-number") {
          setState(() {
            _errorPhoneMsg = appLocalizations.invalidPhoneNumber;
          });
        }
      }
    }
  }

  void _phoneCodeFailed(FirebaseAuthException exception) {
    if (exception.code == "invalid-phone-number") {
      setState(() {
        _errorPhoneMsg = appLocalizations.invalidPhoneNumber;
      });
    }
    else if (exception.code == "too-many-requests") {
      setState(() {
        _errorPhoneMsg = appLocalizations.tooManyTries;
      });
    }
  }

  void _phoneCodeTimeout(String timeout) {
    setState(() {
      _errorPhoneMsg = appLocalizations.timeoutSmsCodeMsg;
    });
  }
}
