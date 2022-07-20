import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  bool _isEmailValid = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _loginTitle(),
              Divider(thickness: 1,),
              _emailInput(),
              SizedBox(height: 30,),
              _passwordInput(),
              SizedBox(height: 30,),
              _forgotButton(),
              _submitButton(),
            ],
          ),
        ),
      ),
    );
    
  }

  Text _loginTitle() {
    return Text(
              'Login',
              style: TextStyle(fontSize: 40, color: Colors.blue),
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
                  labelText: 'Email',
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
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock_outline),
                  labelText: 'Password',
                ),
              ),
            );
  }

  TextButton _forgotButton() {
    return TextButton(
              child: Text('Did you forgot your password?'),
              onPressed: (){
                //TODO: GO TO THE NEXT STEP
              },
            );
  }

  Container _submitButton() {
    return Container(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              child: ElevatedButton(
                child: const Text('Enter'),
                onPressed: EmailValidator.validate(_emailController.text) ? _submit : null, 
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


