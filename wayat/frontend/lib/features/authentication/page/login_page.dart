import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/components/login_title.dart';
import 'package:wayat/common/widgets/components/wayat_title.dart';

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
              const CustomWayatTitle(), 
              const CustomLoginTitle(), 
              _signInButton()],
          ),
        ),
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
