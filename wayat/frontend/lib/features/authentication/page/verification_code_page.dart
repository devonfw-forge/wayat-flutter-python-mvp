import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/lang/lang_singleton.dart';

class CodeValidationPage extends StatefulWidget {
  const CodeValidationPage({Key? key}) : super(key: key);

  @override
  State<CodeValidationPage> createState() => _CodeValidationPageState();
}

class _CodeValidationPageState extends State<CodeValidationPage> {
  final appLocalizations = GetIt.I.get<LangSingleton>().appLocalizations;
  final userSession = GetIt.I.get<SessionState>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool validCode = false;

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
              _codeDescription(),
              _formCode(),
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

  Container _codeDescription() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Column(
        children: [
          Text(
            appLocalizations.codeVerificationTitle,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(appLocalizations.verificationCodeDescription, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Form _formCode() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            _codeInput(),
            _submitButton(),
          ],
        ));
  }

  Container _codeInput() {
    return Container(
        child: TextField(
          keyboardType: TextInputType.number,
        )
    );
  }

  Container _submitButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: ElevatedButton(
        onPressed: !validCode ? null : _submit,
        child: Text(appLocalizations.sendVerificationButton),
      ),
    );
  }

  _submit() {
    // TODO: UPDATE THE USERSESSION STATE TO GO HOME
  }
}
