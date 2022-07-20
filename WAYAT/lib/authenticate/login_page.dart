import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/lang/lang_singleton.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final _emailController = TextEditingController();
  bool _isEmailValid = false;
  final appLocalizations = GetIt.I.get<LangSingleton>().appLocalizations;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _loginTitle(),
                const Divider(thickness: 1,),
                _emailInput(),
                const SizedBox(height: 30,),
                _passwordInput(),
                const SizedBox(height: 30,),
                _forgotButton(),
                _submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
    
  }

  Text _loginTitle() {
    return Text(
      appLocalizations.login, // Login text
      style: const TextStyle(fontSize: 40, color: Colors.blue),
    );
  }

  Container _emailInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child:  TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: const Icon(Icons.alternate_email),
          hintText: 'example@email.com',
          labelText: appLocalizations.email, // Email text
        ),
        onChanged: (value) => setState((){}),
        validator: (value) => EmailValidator.validate(_emailController.text) ? null : 'Enter a Valid Email',
      ),
    );
  }

  Container _passwordInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child:  TextFormField(
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: InputDecoration(
          icon: const Icon(Icons.lock_outline),
          // Password text
          labelText: appLocalizations.password,
        ),
      ),
    );
  }

  TextButton _forgotButton() {
    return TextButton(
      // Forgotten password question text
      child: Text(appLocalizations.forgotPasswQ),
      onPressed: (){
        //TODO: GO TO THE NEXT STEP
      },
    );
  }

  Container _submitButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      child: ElevatedButton(
        onPressed: EmailValidator.validate(_emailController.text) ? _submit : null,
        child: Text(appLocalizations.login), 
      ),
    );
  }

  void _submit() {
    _isEmailValid = EmailValidator.validate(_emailController.text);
    if (_isEmailValid)
    {
      //TODO: GO TO THE NEXT STEP
    }
  }
}


