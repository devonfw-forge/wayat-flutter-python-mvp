import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/lang/lang_singleton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final appLocalizations = GetIt.I.get<LangSingleton>().appLocalizations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _logoWayat(),
                _loginTitle(),
                Column(
                  children: [
                    Text('Phone verification'),
                    Text('A verification code will be send to your phone'),
                  ],
                ),
                _phoneInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _logoWayat() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Text(appLocalizations.appTitle, style: const TextStyle(color: ColorTheme.primaryColor, fontWeight: FontWeight.bold),),
    );
  }

  SizedBox _loginTitle() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Text(
        appLocalizations.login,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
  
  TextField _phoneInput() {
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.phone,
      
    );
  }
}
