import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/features/authentication/common/login_title.dart';
import 'package:wayat/common/widgets/components/wayat_title.dart';
import 'package:wayat/lang/app_localizations.dart';


class PhoneValidationPage extends StatefulWidget {
  const PhoneValidationPage({Key? key}) : super(key: key);

  @override
  State<PhoneValidationPage> createState() => _PhoneValidationPageState();
}

class _PhoneValidationPageState extends State<PhoneValidationPage> {
  final userSession = GetIt.I.get<SessionState>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _validPhone = false;
  String _phoneNumber = "";
  String _errorPhoneMsg = "";

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
              _phoneDescription(),
              _formPhone(),
            ],
          ),
        ),
      ),
    );
  }

  Container _phoneDescription() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Text(
            appLocalizations.phoneNumber,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(appLocalizations.phonePageDescription,
              textAlign: TextAlign.center),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  Form _formPhone() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            _phoneInput(),
            _submitButton(),
          ],
        ));
  }

  IntlPhoneField _phoneInput() {
    return IntlPhoneField(
      // Only numbers are allowed as input
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: InputDecoration(
          errorText: _errorPhoneMsg != "" ? _errorPhoneMsg : null,
          labelText: appLocalizations.phoneNumber,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      initialCountryCode: 'ES',
      onChanged: (phone) {
        setState(() {
          _validPhone = _formKey.currentState!.validate();
          if (_validPhone) _phoneNumber = phone.completeNumber;
        });
      },
    );
  }

  Container _submitButton() {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: CustomOutlinedButton(
        onPressed: !_validPhone ? null : _submit,
        text: appLocalizations.next,
      ),
    );
  }

  _submit() async {
    bool updated =
        await userSession.updatePhone(_phoneNumber);
    if (updated) {
      userSession.setFinishLoggedIn(true);
    } else {
      setState(() {
        _errorPhoneMsg = appLocalizations.phoneUpdateError;
      });
    }
  }
}
