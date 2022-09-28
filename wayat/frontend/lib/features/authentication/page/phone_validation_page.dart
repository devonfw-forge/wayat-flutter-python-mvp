import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/features/authentication/common/login_title.dart';
import 'package:wayat/common/widgets/components/wayat_title.dart';
import 'package:wayat/features/profile/controllers/phone_verification_controller.dart';
import 'package:wayat/lang/app_localizations.dart';

/// Phone validation page for login
class PhoneValidationPage extends StatefulWidget {
  final PhoneVerificationController phoneController;
  PhoneValidationPage({Key? key, PhoneVerificationController? phoneController})
      : phoneController = phoneController ?? PhoneVerificationController(),
        super(key: key);

  @override
  State<PhoneValidationPage> createState() => _PhoneValidationPageState();
}

/// State of Phone validation page for login
class _PhoneValidationPageState extends State<PhoneValidationPage> {
  /// User session information
  final userSession = GetIt.I.get<SessionState>();

  /// Form key used
  final GlobalKey<FormState> _formKey = GlobalKey();

  /// Message of error in phone validation
  String errorSettingPhone = "";

  /// Text style of phone text field
  TextStyle _textStyle(Color color, double size) =>
      TextStyle(fontWeight: FontWeight.w500, color: color, fontSize: size);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          await GetIt.I.get<SessionState>().logOut();
          return true;
        },
        child: Scaffold(
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
        ));
  }

  /// Returns widget with title and description of phone number validation process
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

  /// Returns text field with phone verification text field [_phoneTextField()] and submit button [_submitButton()]
  Form _formPhone() {
    return Form(
        key: _formKey,
        child: Observer(
          builder: (_) => Column(
            children: [
              _phoneTextField(),
              _submitButton(),
              Text(
                errorSettingPhone,
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }

  /// Returns phone text field with prefix phone number field
  Widget _phoneTextField() {
    return IntlPhoneField(
      // Only numbers are allowed as input
      keyboardType: TextInputType.number,
      invalidNumberMessage: appLocalizations.invalidPhoneNumber,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: InputDecoration(
          errorText: widget.phoneController.errorPhoneFormat.isNotEmpty
              ? widget.phoneController.errorPhoneFormat
              : null,
          labelStyle: _textStyle(Colors.black87, 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      initialCountryCode: 'ES',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (newTextValue) =>
          widget.phoneController.validatePhoneNumber(newTextValue),
      onChanged: (phone) {
        widget.phoneController.onChangePhoneNumber(phone, _formKey, context);
      },
    );
  }

  // Returns the submit phone number button
  Container _submitButton() {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: CustomOutlinedButton(
        onPressed: widget.phoneController.validPhone ? _submit : null,
        text: appLocalizations.next,
      ),
    );
  }

  // Updates phone number in user account or set the error message [errorSettingPHone]
  _submit() async {
    final bool updated =
        await userSession.updatePhone(widget.phoneController.phoneNumber);

    if (updated && widget.phoneController.validPhone) {
      userSession.setFinishLoggedIn(true);
    } else {
      errorSettingPhone = appLocalizations.phoneUsed;
      setState(() {});
    }
  }
}
