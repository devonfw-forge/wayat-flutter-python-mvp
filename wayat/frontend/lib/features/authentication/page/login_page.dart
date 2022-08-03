import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/lang/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final SessionState userSession = GetIt.I.get<SessionState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width *0.2, vertical: MediaQuery.of(context).size.height *0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _logoWayat(), 
              _loginTitle(), 
              _signInButton()],
          ),
        ),
      ),
    );
  }

  SizedBox _logoWayat() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Text(appLocalizations.appTitle, style: const TextStyle(color: ColorTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 28),),
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

  SignInButton _signInButton() {
    return SignInButton(
      Buttons.Google,
      onPressed: () {
        userSession.googleLogin();
      },
    );
  }
}
