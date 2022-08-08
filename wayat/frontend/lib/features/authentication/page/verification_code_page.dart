import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/features/authentication/common/login_title.dart';
import 'package:wayat/common/widgets/components/wayat_title.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:wayat/services/authentication/gphone_service_impl.dart';

class CodeValidationPage extends StatefulWidget {
  const CodeValidationPage({Key? key}) : super(key: key);

  @override
  State<CodeValidationPage> createState() => _CodeValidationPageState();
}

class _CodeValidationPageState extends State<CodeValidationPage> {
  final appLocalizations = GetIt.I.get<LangSingleton>().appLocalizations;
  final userSession = GetIt.I.get<SessionState>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _inputSmsCode = "";
  String _errorCodeMsg = "";

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
      // Only numbers are allowed as input 
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: InputDecoration(
        errorText: _errorCodeMsg != "" ? _errorCodeMsg : null,
        label: Text(appLocalizations.codeVerificationTitle),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
      onChanged: (smsCode) {
        setState(() {
          if (smsCode.length == 6) {
            _errorCodeMsg = "";
            _inputSmsCode = smsCode;
          }
          else {
            setState(() {
              _errorCodeMsg = "Codigo SMS debe ser de 6 digitos";
            });
          }
        });
      },
    );
  }

  Container _resendCode() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
        style: TextButton.styleFrom(primary: Colors.black),
        onPressed: () async {
          await userSession.phoneService.sendGoogleSMSCode(
            phoneNumber: userSession.phoneNumber,
            codeTimeout: _codeTimeout,
            verificationFailed: _codeFailed
          );
        },
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
  
  void _codeFailed(FirebaseAuthException exception) {
    if (exception.code == "invalid-phone-number") {
      setState(() {
        _errorCodeMsg = appLocalizations.invalidPhoneNumber;
      });
    }
  }

  void _codeTimeout(String timeout) {
    setState(() {
      _errorCodeMsg = appLocalizations.timeoutSmsCodeMsg;
    });
  }

  CustomOutlinedButton _submitButton() {
    return CustomOutlinedButton(
      onPressed: _submit,
      text: appLocalizations.sendVerification,
    );
  }

  _submit() async {
    if (_inputSmsCode != "") { 
      GooglePhoneService phoneService = userSession.phoneService;
      try{
        await phoneService.verifyGoogleSMSCode(_inputSmsCode);
        bool updated = await userSession.authService.updatePhone(userSession.phoneNumber);
        if (updated) {
          userSession.setFinishLoggedIn(true);
        } else {
          setState(() {
            _errorCodeMsg = appLocalizations.phoneUpdateError;
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "invalid-verification-code") {
          setState(() {
            _errorCodeMsg = appLocalizations.invalidSmsCode;
          });
        }
        else if (e.code == "session-expired") {
          setState(() {
            _errorCodeMsg = appLocalizations.expiredSessionSmsCodeMsg;
          });
          await userSession.phoneService.sendGoogleSMSCode(
            phoneNumber: userSession.phoneNumber,
            codeTimeout: _codeTimeout,
            verificationFailed: _codeFailed
          );
        }
      }
    }
  }
}
