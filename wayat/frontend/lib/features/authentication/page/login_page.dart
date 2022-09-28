import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/features/authentication/common/login_title.dart';
import 'package:wayat/common/widgets/components/wayat_title.dart';
import 'package:wayat/lang/app_localizations.dart';

/// Page that shows google authetication
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// Contains the state of [LoginPage]
class _LoginPageState extends State<LoginPage> {
  /// User session singleton info
  final SessionState userSession = GetIt.I.get<SessionState>();

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

  /// Returns a sign in button and a google image
  Widget _signInButton() {
    return InkWell(
      onTap: () async {
        await userSession.login();
      },
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Image.asset(
                'assets/images/google_icon.png',
                height: 20,
              ),
              const SizedBox(width: 12),
              Text(appLocalizations.loginGoogle),
            ],
          ),
        ),
      ),
    );
  }
}
