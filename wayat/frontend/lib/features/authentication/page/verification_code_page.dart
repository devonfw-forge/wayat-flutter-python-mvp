import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/features/authentication/common/login_title.dart';
import 'package:wayat/common/widgets/components/wayat_title.dart';
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
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: MediaQuery.of(context).size.height * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomWayatTitle(),
              const CustomLoginTitle(),
              _codeDescription(),
              _formCode(),
            ],
          ),
        ),
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
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(appLocalizations.verificationCodeDescription, textAlign: TextAlign.center),
          const SizedBox(
            height: 25,
          ),
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
            _resendCode(),
            _submitButton(),
          ],
        ));
  }

  TextField _codeInput() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        label: Text(appLocalizations.codeVerificationTitle),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );
  }

  Container _resendCode() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
        style: TextButton.styleFrom(primary: Colors.black),
        onPressed: (){},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.refresh),
            Text(appLocalizations.resendCode),
          ],
        ),
      ),
    );
  }

  CustomOutlinedButton _submitButton() {
    return CustomOutlinedButton(
      onPressed: _submit,
      text: appLocalizations.sendVerificationButton,
    );
  }

  _submit() {
    userSession.setFinishLoggedIn(true);
  }
}
