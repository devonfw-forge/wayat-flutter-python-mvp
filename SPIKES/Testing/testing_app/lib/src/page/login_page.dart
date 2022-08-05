import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:testing_app/components/wayat_title.dart';
// import 'package:get_it/get_it.dart';
// import 'package:wayat/app_state/user_session/session_state.dart';
// import 'package:wayat/features/authentication/common/login_title.dart';
// import 'package:wayat/common/widgets/components/wayat_title.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final SessionState userSession = GetIt.I.get<SessionState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.2,
              vertical: MediaQuery.of(context).size.height * 0.1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomWayatTitle(),
                const CustomLoginTitle(),
                _signInButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  SignInButton _signInButton() {
    return SignInButton(
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(10)),
      elevation: 0.0,
      Buttons.Google,
      onPressed: () {
        // userSession.googleLogin();
      },
    );
  }
}

class CustomLoginTitle extends StatelessWidget {
  const CustomLoginTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.10,
      child: Text(
        'Login',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }
}